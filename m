Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i85ARdrT017008
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 06:27:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i85ARbt0027777
	for <selinux@tycho.nsa.gov>; Sun, 5 Sep 2004 10:27:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Additional rule files
Date: Sun, 5 Sep 2004 20:27:34 +1000
Cc: selinux@tycho.nsa.gov
References: <1094260356.29689.44.camel@wintermute.xmldesign.de>
In-Reply-To: <1094260356.29689.44.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WouOB+aCixHEMhE"
Message-Id: <200409052027.34499.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_WouOB+aCixHEMhE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 4 Sep 2004 11:12, Erich Schubert <erich@debian.org> wrote:
> The next two rule sets are for the statistic tools "bindgraph" and
> "mailgraph". The first parses bind query logs and does nice graphs out
> of them, the second does the same for postfix+amavis logs.

can_exec_any(http_request_t)

The above line in bindgraph.te is bad.  The policy for program A should not 
grant significant permissions to program B to access the rest of the system.  
Allowing program B to access program A files, to run programs in the domain 
for program A, and to kill such programs may be OK (depending on what your 
goals are).  But allowing some wide access to unrelated parts of the system 
risks breakage.

In this case it may do no harm, but if nothing else it sets a bad precedent.

I have attached a modified version of bindgraph.  I removed the entire fnord 
section (see my next message).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_WouOB+aCixHEMhE
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bindgraph.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bindgraph.te"

#DESC BINDGRAPH - bind statistics graph tool
# Authors:  Erich Schubert <erich@debian.org>
# X-Debian-Packages: bindgraph
#

daemon_domain(bindgraph)
daemon_domain(bindgraph_cgi)
# lib is for the RRD files (data gathered)
type bindgraph_lib_t, file_type, sysadmfile;
# the cache is storing generated images
type bindgraph_cache_t, file_type, sysadmfile;

# maybe the same pid file removal rule is needed as for mailgraph?

# read log files
r_dir_file(bindgraph_t, var_log_t)

# write own lib files (RRD files)
allow bindgraph_t var_lib_t:dir search;
create_dir_file(bindgraph_t, bindgraph_lib_t)
# the cgi may only read the RRD files
r_dir_file(bindgraph_cgi_t, bindgraph_lib_t)

# cgi can write in cache
create_dir_file(bindgraph_cgi_t, bindgraph_cache_t)
allow bindgraph_cgi_t var_lib_t:dir search;

# perl behaviour
allow { bindgraph_t bindgraph_cgi_t } { bin_t sbin_t }:dir { search getattr };
r_dir_file({ bindgraph_t bindgraph_cgi_t }, usr_t)
allow { bindgraph_t bindgraph_cgi_t } { random_device_t urandom_device_t }:chr_file read;


--Boundary-00=_WouOB+aCixHEMhE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
