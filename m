Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9A2akpf024896
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 22:36:46 -0400
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9A2aiaK005516
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 02:36:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Murray McAllister <mmcallis@redhat.com>
Subject: Re: user guide drafts: Archiving Files with tar/star
Date: Fri, 10 Oct 2008 12:36:38 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <48EDAE09.8070903@redhat.com> <200810101251.30094.russell@coker.com.au> <48EEB91C.4080205@redhat.com>
In-Reply-To: <48EEB91C.4080205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101336.41120.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 10 October 2008 13:08, Murray McAllister <mmcallis@redhat.com> 
wrote:
> > The inheriting of file contexts from a directory (in the absence of
> > policy rules specifying otherwise) has AFAIK always been the design of SE
> > Linux.
>
> When would "tar | restorecon -f -" be used if files inherit contexts
> from parent directories (if policy has not be changed)? Sorry, I am a
> bit slow :)

For the case where the desired context for a file does not match the default 
context.

One example (which is probably covered by restorecond) is /etc/shadow.  If you 
extract a tar file which has a file named shadow with the current directory 
being /etc then it will get the type etc_t (while such things are not 
generally recommended they are in the range of tasks which are not uncommon 
for sysadmins).  The command described previously would result in the file 
being relabelled as shadow_t.  Of course it would have a race condition, but 
let's assume for the sake of discussion that the machine is in single-user 
mode.

The above example assumes that the file /etc/shadow does not exist at the time 
the tar file is extracted (tar will truncate an existing file and keep the 
same context).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
