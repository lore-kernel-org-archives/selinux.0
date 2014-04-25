Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3PGX4qM031936
 for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2014 12:33:04 -0400
Message-ID: <535A8E34.5090009@tresys.com>
Date: Fri, 25 Apr 2014 12:32:52 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, <selinux@tycho.nsa.gov>,
 <setools-bugs@tresys.com>
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy
 features
References: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/08/2014 10:52 AM, Richard Haines wrote:
> These four patches will update setools-3.3.8.tar.bz2 available from
> http://oss.tresys.com/projects/setools/wiki/download
> 
> I know this is not being fully supported but as I use APOL frequently
> I thought I would update it to support the latest policy version 29 (I
> could be the only user!!!). Tested on latest Fedora 20 x86_64
> 
> The enhancements and bug fixes are listed below. All patches should be
> applied to setools-3.3.8 and then built as follows:
> 
>   autoreconf -i -s
>   ./configure
>   make
>   make install
> 
> This will put the binaries in /usr/local/bin, data files in
> /usr/local/share/setool-3.3, and libraries in /usr/local/lib.
> Assuming that /usr/local/bin is in your $PATH and /usr/local/lib in
> $LD_LIBRARY_PATH everything should now work.
> 
> PATH=/usr/local/bin:$PATH
> export LD_LIBRARY_PATH=/usr/local/lib
> 
> APOL enhancements and bug fixes
> -------------------------------
> * Add permissive type and typebound support to Types tab.
> * Add new Constraints tab to search all constraint statements.
> * Add new Bounds tab to search for userbound, rolebound and
>   typebound statements.
> * Add new policy capabilities tab.
> * Add filename type_transition support on TE Rules tab.
> * Add new Default Object tab to support defaultuser, defaultrole,
>   defaulttype and defaultrange rules.
> * Add new Namespaces tab to list CIL namespaces. This will also
>   show any users, roles, types, classes, booleans, sensitivities
>   and categories declared in each namespace. A global namespace is
>   automatically generated (GLOBAL-NS).
> * Update Query/Policy Summary page to show the number of new
>   rules added plus the policy handle_unknown flag.
> * Fixed File Contexts tab to stop hang when building the fc
>   index when broken links/files found (libsefs). Also fixes indexcon util.
> * Fixed Booleans tab to display CIL namespace booleans.
> * Updated apol_help.txt to reflect the changes made plus how to
>   load the running policy.
> 

All patches look good and applied. Thanks!

- Steve
