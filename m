Subject: Re: Shouldn't this avc message be dontaudited?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <416419A5.6030809@redhat.com>
References: <416419A5.6030809@redhat.com>
Content-Type: text/plain
Message-Id: <1097085479.11370.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 13:57:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-06 at 12:13, Daniel J Walsh wrote:
> How come I am getting this avc message
> 
> Oct  6 11:58:44 localhost kernel: audit(1097078324.850:0): avc:  denied  
> { name_bind } for  pid=2471 exe=/usr/sbin/nscd src=953 
> scontext=user_u:system_r:nscd_t tcontext=system_u:object_r:rndc_port_t 
> tclass=tcp_socket
> 
> When I have this rule?
> 
> dontaudit nscd_t reserved_port_t:{ tcp_socket udp_socket } name_bind;

Different types - reserved_port_t (covers any otherwise unspecified
reserved ports) vs. rndc_port_t.  Why would nscd try binding to this
port anyway?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
