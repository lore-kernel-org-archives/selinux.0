Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FJ7nL9010328
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 14:07:49 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FJ4Mw0009203
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 19:04:23 GMT
Date: Tue, 15 Feb 2005 19:16:40 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050215191640.GA26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 15, 2005 at 01:14:53PM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 10:53, Luke Kenneth Casson Leighton wrote:
> > so basically, my question boils down to this:
> > 
> > * _should_ sshd, after a fork, be still running in sshd_t?
> 
> I'm not sure I follow your posting.  

 see example ps -axZ below as to the bit i have concerns about
 (process 5001 in the example).

> Transitions normally only occur
> upon execve.  sshd should transition upon executing the shell, of
> course.  

 and then that shell does a further execve of the sftp-server?

> IIRC, there is an issue with regard to SELinux not being able
> to fully leverage the privilege separation support in sshd since that
> requires dynamic transitions.  Of course, since dynamic transition
> support now exists, someone could look into changing sshd to use it for
> finer-grained privilege bracketing.
  
  that would provide me with a solution 6 months down the line
  [when FC4 or FC5 is released] and i am therefore planning ahead:
  the present solution is a bit iffy.

  i'll try to explain a bit better.

  when i run ps -axZ, i get this:

  2000 sshd_t	                /usr/sbin/sshd
  5001 sshd_t	                /usr/sbin/sshd
  5004 restricted_sftp_user_t	/usr/libexec/ssh/sftp-server

  now, when i do a lsof -p 5001, it shows that that sshd, which is
  still running in sshd_t, has the open TCP connection.

  lsof -p 5004 shows sftp-server has only a couple of sockets open.

  what the _heck_ is that sshd doing still running as root, or
  more specifically, what's it doing still running under sshd_t?

  the process 5004 would be where the execve() took place, so
  it at least went to restricted_user_t, such that this works:

	  domain_auto_trans(restricted_user_t, sftp_server_exec_t,
			    restricted_sftp_user_t)

 so there are at least two forks() - one to handle the incoming
 connection and one to handle the user context (and a socket
 of some type is set up between the two to "disconnect" the
 user shell from the TCP socket).

 then, the shell is execve()'d in the last of these fork()s, and then
 sftp-server is execve()'d in that.

 unfortunately, then, as things stand, it's not possible to
 associate a security context with the "initial" fork - the
 one that holds the TCP connection.

 ... and what you are saying is that now that dynamic transitions
 are possible, it might be doable?

 okay.

 if nothing else, this has been an opportunity for me to get my
 head round the issues, and to understand what's going on.

 i'll put in my projects "TODO" list something for the client to
 fund if they want to improve useability.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
