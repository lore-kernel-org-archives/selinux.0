From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: This weeks diffs
Date: Fri, 22 Apr 2005 18:42:37 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <4266BFF9.10906@redhat.com>
In-Reply-To: <4266BFF9.10906@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BkLaCJxOX0G3nYc"
Message-Id: <200504221842.41749.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_BkLaCJxOX0G3nYc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 21 April 2005 06:47, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Several fixes to get MLS policy working better around initrc_tty files.
>
> Change hostname_t to only transition when run by dhcpc_t.  (Added to
> targeted)
>
> Several fixes to allow dhclient to work properly.

+daemon_domain(dhcpc, `, privuser')

What is going on here?  Is dhcpc_t trying to launch processes on behalf of the 
user?

> More fixes for initrc_t for removal of unconfined_domain.
>
> Several fixes for amanda to be able to backup a system.
>
> Allow httpd_suexec_t to create httpd_log files.
>
> Split auditd policy out into auditd_t for audit daemon and auditctl_t
> for autoctl program
>
> Allow cups to communicate with desktop in targeted policy.
>
> Fix prelink to be able to be run by admin.
>
> Misc file_context fixes.
>
> fix ypbind_macros.te to use name_connect.

+allow getty_t initrc_devpts_t:chr_file rw_file_perms;

How/why does getty get to access a /dev/pts file?  I don't think that this is 
required, if it is then it's a gross bug in getty or init.

+allow udev_t device_t:file rw_file_perms;

This is a bug.  There should never be a file labelled as device_t.

+/sbin/rdisc            --      system_u:object_r:traceroute_exec_t

Isn't rdisc supposed to run as a daemon?  If so then it will need a pidfile 
and thus more access than traceroute_t gets.  I've attached a first cut at a 
policy for it, it doesn't work yet as I don't have a test setup though.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_BkLaCJxOX0G3nYc
Content-Type: text/plain;
  charset="utf-8";
  name="rdisc.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rdisc.fc"

/sbin/rdisc		system_u:object_r:rdisc_exec_t

--Boundary-00=_BkLaCJxOX0G3nYc
Content-Type: text/plain;
  charset="utf-8";
  name="rdisc.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rdisc.te"

#DESC rdisc - network router discovery daemon
#
# Author:  Russell Coker <russell@coker.com.au>

daemon_base_domain(rdisc)
allow rdisc_t self:rawip_socket create_socket_perms;
allow rdisc_t self:udp_socket create_socket_perms;
allow rdisc_t self:capability net_raw;

--Boundary-00=_BkLaCJxOX0G3nYc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
