Subject: Re: setools, version 0.8
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Mauro Chiarugi <vlaovic@libero.it>
Cc: Frank Mayer <mayerf@tresys.com>, SELinux@tycho.nsa.gov, selinux@tresys.com
In-Reply-To: <20030410211532.7cb35199.vlaovic@libero.it>
References: <004901c2ff81$959a32d0$6600a8c0@columbia.tresys.com>
	 <20030410211532.7cb35199.vlaovic@libero.it>
Content-Type: text/plain
Message-Id: <1050067377.3715.43.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Apr 2003 09:22:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-04-10 at 15:15, Mauro Chiarugi wrote:
> my name is Mauro Chiarugi, an italian student of University of Ancona.
> I'd like to port SELinux under Debian, but i don't know now SeLinux very
> well ;) ..so i'd like be sure that i know all released resources/tools
> that are now avaible (i'll use LSM tree, with OpenWall + SELinux + LIDS
> + DTE ..). Which tools are avaible now???
> I've just seen tresys tools and dte tools (at
> http://www.cs.wm.edu/~hallyn/dte/), are there other tools to configure
> all modules?? Which are most important?? Which do i need??

Just to clarify, you can't use SELinux+LIDS+DTE together, because they
will conflict with each other in their usage of the LSM security
fields.  SELinux does provide simple support for stacking with the
capabilities or dummy modules, and you may be able to stack SELinux with
OWLSM (which is not OpenWall, just a port of a subset of OpenWall to LSM
by different people) as long as you don't enable CONFIG_OWLSM_FD (which
would conflict in its usage of the linux_binprm security field).  We
typically recommend using SELinux+capabilities, so that you preserve the
existing Linux access control logic and API (some applications depend on
Linux supporting capabilities).

The Tresys setools were merged into the NSA SELinux releases starting
with the January 2003 release; they seem to be the most mature tools
available.  A couple of simple scripts for policy generation and
analysis have been contributed, such as the newrules.pl script (included
in the release) and a cando script (see the mailing list archives).  The
COPS Lab at UNT developed a TE rule browser that operated on the binary
policy a while back, but I'm not sure that it is still active or whether
it offers any capability beyond the Tresys setools.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
