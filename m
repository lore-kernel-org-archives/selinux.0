Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JIDu35006046
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 14:13:56 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JIDt2o015525
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 18:13:55 GMT
Subject: Re: kudzu needs to init_telinit to change its runlevel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02A1B.7040007@redhat.com>
References: <45F02A1B.7040007@redhat.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 18:13:48 +0000
Message-Id: <1174328028.16707.13.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 10:22 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/admin/kudzu.te        2007-01-02 12:57:51.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/admin/kudzu.te     2007-03-08 08:42:36.000000000 -0500
> @@ -103,6 +103,7 @@
>  init_use_fds(kudzu_t)
>  init_use_script_ptys(kudzu_t)
>  init_stream_connect_script(kudzu_t)
> +init_telinit(kudzu_t)
>  
>  libs_use_ld_so(kudzu_t)
>  libs_use_shared_libs(kudzu_t)

This seems odd to me.  Why would kudzu need to change the runlevel?  I
thought it just detected and configured hardware.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
