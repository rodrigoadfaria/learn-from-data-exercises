\ProvidesClass{lista}

\LoadClass{article}

\DeclareOption{noindent}{\setlength{\parindent}{0cm}}
\DeclareOption{nopagenumber}{\pagenumbering{gobble}}

\ExecuteOptions{11pt, oneside, onecolumn}
\ProcessOptions*

\setlength\parskip{0.4cm}

\RequirePackage[cm]{fullpage}
\RequirePackage[top=3cm, bottom=3cm, left=2.5cm, right=2.5cm]{geometry}

\RequirePackage[T1]{fontenc}
\RequirePackage[brazil]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[pdftex]{graphicx}
\RequirePackage{setspace}
\RequirePackage{indentfirst}
\RequirePackage{courier}
\RequirePackage{type1cm}
\RequirePackage[fixlanguage]{babelbib}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{color}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage[mathscr]{euscript}
\RequirePackage{dsfont}
\RequirePackage{float}
\RequirePackage{cases}
\RequirePackage{numprint}

% Definições de padrões
\def\conjR{\mathds{R}}
\def\conjQ{\mathds{Q}}
\def\conjZ{\mathds{Z}}
\def\conjN{\mathds{N}}


% Cores

\definecolor{light-gray}{gray}{0.6}
\definecolor{dark-gray}{gray}{0.25}

\newenvironment{redt}{\color{red}}{}
\newenvironment{grayt}{\color{light-gray}}{}

\newenvironment{pradireita}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \listparindent\itemindent
                        \advance\leftmargin 0.2em}%
               \item\relax}
               {\endlist}

% Environment de exercícios

\newenvironment{exercicios}
             {
                \newcommand\enun[1]{\item[\textbf{E 2.##1}]}

                \newenvironment{enunciado}[1]
                    {\enun{##1}\color{dark-gray}}
                    {\vspace{0.3cm} \hrule \vspace{0.3cm}}
                    
                \newcommand\letra[1]{\textbf{(##1)~}}

                \begin{enumerate}
               }
               {\end{enumerate}}


% Auxiliar para cabeçalho

\newcounter{cnt}
\newcommand\aluno[2]{
  \stepcounter{cnt}
  \csdef{nome\thecnt}{#1}
  \csdef{nusp\thecnt}{#2}}
\newcommand\getnome[1]{
  \csuse{nome#1}}
\newcommand\getnusp[1]{
  \csuse{nusp#1}}
\newcommand\titulo[1]{\csdef{vartitulo}{#1}}
\newcommand\materia[1]{\csdef{varmateria}{#1}}

\newcounter{cttp}
\newcommand\lolaluno[1]{\getnome{#1} & \getnusp{#1}}
\newcommand\printalunos{
  \noindent
  \begin{tabular}{l l}
  \whiledo{\value{cttp}<\value{cnt}}{
    \stepcounter{cttp}
    \lolaluno{\thecttp}\\ }
\end{tabular}}

\newcommand\cabecalho{
\begin{center}
\Large{\textbf{\csuse{vartitulo}}}\\
\large{\textbf{\csuse{varmateria}}}\\
\vspace{0.5cm}
\printalunos
\end{center}
}
