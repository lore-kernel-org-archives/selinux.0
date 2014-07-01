Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61AgKvF019452
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 06:42:20 -0400
Message-ID: <53B2908B.3060407@redhat.com>
Date: Tue, 01 Jul 2014 06:42:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Where's the class defined in file_contexts*
References: <53B2759A.2030209@gmail.com>
In-Reply-To: <53B2759A.2030209@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/2014 04:47 AM, dE wrote:
> The default security context of a object also depends on it's class.
>
> I was looking at
> etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts*, but I
> couldn't see any definition of a class.
>
> Also semanage fcontext doesn't have an option define a class. Entries
> are based only on files and directories.
>
> If you get red text in this email please notify.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
I believe the answer to your question is:

man semanage-fcontext
...
       -f [{a,f,d,c,b,s,l,p}], --ftype [{a,f,d,c,b,s,l,p}]
              File Type. This is used with fcontext. Requires a file
type as shown in the mode field by ls, e.g. use 'd' to match only
directories
              or  'f'  to  match  only  regular  files. The following
file type options can be passed: f (regular file),d (directory),c (character
              device), b (block device),s (socket),l (symbolic link),p
(named pipe).  If you do not specify  a  file  type,  the  file  type  will
              default to "all files".
