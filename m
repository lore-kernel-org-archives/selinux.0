Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i01KnQRb023245
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 15:49:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i01KnP7m025092
	for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 20:49:25 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i01KnOLC025089 for <selinux@tycho.nsa.gov>; Thu, 1 Jan 2004 20:49:24 GMT
Received: from rom.cip.informatik.uni-muenchen.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 4C3CE4357A
	for <selinux@tycho.nsa.gov>; Thu,  1 Jan 2004 21:49:24 +0100 (CET)
Date: Thu, 1 Jan 2004 21:49:24 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: selinux@tycho.nsa.gov
Subject: Re: vim selinux syntax file
Message-ID: <20040101204924.GL4560@rom.cip.informatik.uni-muenchen.de>
References: <16236.1070616291@www6.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
In-Reply-To: <16236.1070616291@www6.gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

* carstengrohmann@gmx.de [2003-12-05 11:14]:
> has anybody writen an vim syntax file of the selinux policy? 

I have recently written a syntax file for te-files, it is attached as
te.vim. To use it, drop the file into /usr/share/vim/current/syntax/ or
~/.vim/syntax/. You can autoload the syntax-file by adding something
like the following to your filetype.vim[1]:
        augroup filetypedetect
        au BufNewFile,BufRead *.te     setf te
        augroup END

Also attached is a patch against the policy-Makefile which implements
ctags-support for the policy source.
After a "make tags" you can (in vim) press Control-] over every
attribute, type or macro and vim will directly jump to its definition.
If the tags-file is not in your working directory you will have to tell
vim how to find it (:set tags=...)
You will need the exuberant ctags-package for this functionality.

Happy New Year to you all!

Thomas Bleher

[1]: The global filetype.vim resides in /usr/share/vim/current/, the
local equivalent is in ~/.vim/


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="te.vim"

" Vim syntax file
" Language:	TE (SELinux Type Enforcement Policy)
" Author:	Thomas Bleher <ThomasBleher@gmx.de>
" Lastchange:	2003 Dec 30
" URL:		http://www.cip.informatik.uni-muenchen.de/~bleher/selinux/te.vim 
" uses m4.vim, some code taken from cpp.vim
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" First load the M4 syntax
if version < 600
  so <sfile>:p:h/m4.vim
else
  runtime! syntax/m4.vim
  unlet b:current_syntax
endif

syn sync	minlines=100

" define the te syntax
syn keyword	teStatement	allow dontaudit auditallow neverallow type attribute type_change user role type_transition dominance alias types roles
syn keyword	teTodo		TODO XXX FIXME contained
syn match	teDescription	/\<\(Authors\=\>\|X-Debian-Packages:\|DESC\>\).*/ contained
syn match	teComment	/#.*/ contains=teTodo,teDescription
syn match	teNegated	/\~\(\w\|\$\)\+/
syn region	teNegated	start="\~{" end="}" contains=@m4Top
syn match	teSpecial	/\*/

" highlight teStatements and teComments inside of m4-macros
syn cluster	m4Top		contains=m4Comment,m4Constants,m4Special,m4Variable,m4String,m4Paren,m4Command,m4Statement,m4Function,teStatement,teComment,teNegated
" change m4Type to allow lowercase-macros
syn region	m4Function	matchgroup=m4Type      start="\<[_A-Za-z]\w*("he=e-1 end=")" contains=@m4Top

" Default highlighting
if version >= 508 || !exists("did_te_syntax_inits")
  if version < 508
    let did_te_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink teStatement	Statement
  HiLink teTodo		Todo
  HiLink teDescription	Underlined
  HiLink teComment	Comment
  HiLink teNegated	Special
  HiLink teSpecial	Special
  delcommand HiLink
endif

let b:current_syntax = "te"

--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="Makefile.patch"

--- Makefile.orig	2003-12-06 18:17:04.000000000 +0100
+++ Makefile	2003-12-30 18:11:52.000000000 +0100
@@ -133,8 +133,24 @@
 $(FC): $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc
 	cat $(FCFILES) > $@
 
+# Create a tags-file for the policy:
+# we need exuberant ctags; unfortunately it is named differently on different distros, sigh...
+pathsearch = $(firstword $(wildcard $(addsuffix /$(1),$(subst :, ,$(PATH))))) # taken from make-docs
+CTAGS := $(call pathsearch,ctags-exuberant) # debian naming scheme
+ifeq ($(strip $(CTAGS)),)
+CTAGS := $(call pathsearch,ctags) # suse naming scheme
+endif
+
+tags: $(wildcard *.te types/*.te domains/*.te domains/misc/*.te domains/program/*.te domains/program/unused/*.te macros/*.te macros/program/*.te)
+	@($(CTAGS) --version | grep -q Exuberant) || (echo ERROR: Need exuberant-ctags to function!; exit 1)
+	@LC_ALL=C $(CTAGS) --langdef=te --langmap=te:..te \
+	  --regex-te='/^[ \t]*type[ \t]+(\w+)(,|;)/\1/t,type/' \
+	  --regex-te='/^[ \t]*attribute[ \t]+(\w+);/\1/a,attribute/' \
+	  --regex-te='/^[ \t]*define\(`(\w+)/\1/d,define/' $^
+
 clean:
 	rm -f policy.conf
+	rm -f tags
 	rm -f tmp/*
 	rm -f $(FC)
 # for the policy regression tester

--Fba/0zbH8Xs+Fj9o--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
