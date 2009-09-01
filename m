Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n81CTvkA023148
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 08:29:57 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n81CVBs8020066
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 12:31:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/5] cr: checkpoint the active LSM and =?iso-8859-1?q?add=09RESTART=5FKEEP=5FLSM?= flag
Date: Tue, 1 Sep 2009 22:29:30 +1000
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20090828210041.GA27878@us.ibm.com> <20090830134809.GA14699@hallyn.com> <4A9ACBD4.4020804@schaufler-ca.com>
In-Reply-To: <4A9ACBD4.4020804@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200909012229.48973.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 31 Aug 2009, Casey Schaufler <casey@schaufler-ca.com> wrote:
> I seem to be having some trouble presenting my point. It's not about
> the passwords. It's not about the firewall configuration. It's not
> even really about the SELinux policy. It's about the total security
> configuration of the system. This is a problem with checkpoint/restart
> in general and there isn't much we can do about reassigning user id
> and other bad things that can happen.
>
> If the admin decides that an action is acceptable because the SELinux
> policy prevents some other action it had better be the case that a
> process was never allowed to perform that "other action". If you allow
> restart across policy changes you can't be sure that the process has
> not performed such an "other action". Processes are not stateless.

Of course we potentially have the same issue when changing a boolean, and when 
loading a new policy on a running system.  In a realistic scenario, if you 
make a change that allows a process context to write to a public data store 
while at the same time denying read access to secret data then you also need 
to purge the contents of any files that the process may open for read/write.

Similar problems can also occur using Unix permissions and certain 
combinations of chmod with setuid/setgid bits.  Of course most potential 
cases of triggering this issue with Unix permissions are extremely contrived 
and wouldn't be a likely attack scenario.  The best example I can think of 
with Unix permissions is access to sound devices.  If a system is configured 
to add the "audio" supplementary group to a user's session when they login at 
the console then they can keep a detached process running to maintain access 
to the audio devices (and anything else permitted to that group).


PS  Do we really need so many on the CC list?  I removed a few entries of 
people who are on the SE Linux list.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
