\ProvidesClass{tudothesis}[2024/05/17 v0.1 wrapper to scrbook for thesis at Leipzig University]
% Option for leipzig colors:
\newif\if@ulcolor\@ulcolorfalse
\DeclareOption{ulcolor}{\@ulcolortrue}

% All other Options go to KOMA-Script
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\PassOptionsToPackage{bibliography=totoc}{biblatex}
\ProcessOptions\relax

\LoadClass[
  headsepline,            % line  between header and text body
  bibliography=totoc,     % bibliography as unnumbered chapter in toc
  numbers=noenddot,       % no dot after figure/table number
  captions=tableheading,  % correct spacing for table headings
  titlepage=firstiscover, % symmetrical margins on titlepage
  headings=normal         % size of chapter headings slightly smaller
]{scrbook}


% Define our beloved tu colour:
\RequirePackage{xcolor}
\xdefinecolor{leipzigDarkRed}{RGB}{176,47,44}%
\xdefinecolor{leipzigLightRed}{RGB}{214,66,66}%
\xdefinecolor{leipzigLightBlue}{RGB}{138,194,209}%
\xdefinecolor{leipzigLightGrey}{RGB}{201,201,201}%
\xdefinecolor{leipzigDarkGrey}{RGB}{38,42,49}%

\RequirePackage{caption}
\RequirePackage{subcaption}

% add some Color to structural elements if option ulcolor was given
\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}

\KOMAoption{headsepline}{0.5pt}
\if@ulcolor%
  \addtokomafont{title}{\color{leipzigDarkRed}}          % title on titlepage
  \addtokomafont{chapter}{\color{leipzigDarkRed}}     % headlines of the chapters, sections etc. 
  \setkomafont{headsepline}{\color{leipzigDarkRed}}        % line between header and text body
  \DeclareCaptionFont{leipzigDarkRed}{\color{leipzigDarkRed}}
  \captionsetup{%
              labelfont={bf,leipzigDarkRed},     % bold label in tu colour
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\else
  \captionsetup{%
              labelfont=bf,               % bold label
              format=plain,               % no indentation under the label
              width=0.9\textwidth,        % slightly smaller width than text
              font=small,                 % font slightly smaller than text
            }
\fi

% equation numbers of form chapter.equationnumber
\RequirePackage{amsmath}%
\renewcommand{\theequation}{\thechapter{}.\arabic{equation}}%
\numberwithin{equation}{chapter}%

% store the title in \thetitle, so one can access it in the document
\let\oldtitle\title%
\renewcommand{\title}[1]{\oldtitle{#1}\newcommand{\thetitle}{#1}}

% initialize commands:
\newcommand\thebirthplace{}
\newcommand\thechair{}
\newcommand\thedivision{}
\newcommand\thethesisclass{}
\newcommand\thesubmissiondate{}
\newcommand\thefirstcorrector{}
\newcommand\thesecondcorrector{}

% new commands for information about the thesis
\newcommand\birthplace[1]{\renewcommand\thebirthplace{geboren in #1}}
\newcommand\chair[1]{\renewcommand\thechair{#1}}
\newcommand\division[1]{\renewcommand\thedivision{#1}}
\newcommand\thesisclass[1]{\renewcommand\thethesisclass{#1}}
\newcommand\submissiondate[1]{\renewcommand\thesubmissiondate{#1}}
\newcommand\firstcorrector[1]{\renewcommand\thefirstcorrector{#1}}
\newcommand\secondcorrector[1]{\renewcommand\thesecondcorrector{#1}}

% set title page elements
\subject{\thethesisclass}
\publishers{\thechair \\ \thedivision \\ Leipzig University}

% page for the correctors
\newcommand{\makecorrectorpage}{%
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{tabular}{@{}l@{\hspace{2em}}l@{}}
      Primary supervisor:  & \thefirstcorrector \\
      Secondary supervisor: & \thesecondcorrector \\
      Submission date:    & \thesubmissiondate
  \end{tabular}
  \newpage
}

% add birthplace to author
\let\oldauthor\author
\renewcommand\author[1]{%
  \oldauthor{#1 \\ \thebirthplace}
}
