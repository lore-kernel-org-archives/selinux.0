Subject: Re: Architectural doubts
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Juan =?ISO-8859-1?Q?Gonz=E1lez?= <jgonzale@gmail.com>
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <fd0153ad05010614044e6b7c75@mail.gmail.com>
References: <fd0153ad05010612546d5c87e9@mail.gmail.com>
	 <1105045386.24438.176.camel@moss-spartans.epoch.ncsc.mil>
	 <fd0153ad05010614044e6b7c75@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Jan 2005 16:41:35 +0530
Message-Id: <1105096295.19541.2.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Thu, 2005-01-06 at 23:04 +0100, Juan González wrote:
> Me question is, SELinux and LSM share the method to catch system
> entry, via hooks.
> I'm right?¿
> 
Of course yes. LSM is all about hooks. There are 167+ hooks in the
kernel which implement MAC (Mandatory Access Control) parallel to good
old DAC  (Discretionary Access Control).

Jaspreet

> 
> On Thu, 06 Jan 2005 16:03:06 -0500, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > On Thu, 2005-01-06 at 15:54, Juan González wrote:
> > > SELinux is currently implemented as an LSM module or is a variant of LSM itself?
> > 
> > As a module that relies on the LSM framework.  SELinux started life as
> > its own kernel patch implementing the Flask architecture in the Linux
> > kernel, with the security policy logic encapsulated in the security
> > server (policy engine).  Then, when the LSM project was started, the
> > SELinux project participated in the development of the LSM framework and
> > SELinux was rewritten to use LSM, encapsulating all of SELinux
> > (including the Flask architecture and the security server) within the
> > SELinux module.  Then both LSM and SELinux were merged into the mainline
> > kernel, and are both included in Linux 2.6.
> > 
> > --
> > Stephen Smalley <sds@epoch.ncsc.mil>
> > National Security Agency
> > 
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
