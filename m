Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96IhcrT007525
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 14:43:38 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96IgTnN018184
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 18:42:30 GMT
Date: Wed, 6 Oct 2004 19:54:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Shouldn't this avc message be dontaudited?
Message-ID: <20041006185443.GH5790@lkcl.net>
References: <416419A5.6030809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <416419A5.6030809@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ah, i got exactly the same thing: stephen assures me that this is
because i am using an older version of checkpolicy with a recent version
of everything-else.

by installing checkpolicy from the sf.net cvs he assures me that the
problem goes away.

sure enough, i find that two weeks ago i upgraded everything
but checkpolicy.

l.


On Wed, Oct 06, 2004 at 12:13:25PM -0400, Daniel J Walsh wrote:
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
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
