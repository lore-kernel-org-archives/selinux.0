Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43F0qAs025669
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 11:00:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l43F0qqf021303
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 15:00:52 GMT
Subject: Re: squid patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46278600.2010806@redhat.com>
References: <46278600.2010806@redhat.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 15:00:26 +0000
Message-Id: <1178204426.445.64.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 11:08 -0400, Daniel J Walsh wrote:
> @@ -181,3 +184,12 @@
>  #squid requires the following when run in diskd mode, the recommended setting
>  allow squid_t tmpfs_t:file { read write };
>  ') dnl end TODO
> +
> +optional_policy(`
> +       apache_content_template(squid)
> +       corenet_tcp_connect_http_cache_port(httpd_squid_script_t)
> +       squid_read_config(httpd_squid_script_t)
> +       allow httpd_squid_script_t self:tcp_socket create_socket_perms;
> +       sysnet_read_config(httpd_squid_script_t)
> +       corenet_non_ipsec_sendrecv(httpd_squid_script_t)
> +')

This brings up a problem to which I currently don't have a good
solution.  Due to the encapsulation, the squid module doesn't actually
know how many types are created or their names when using
apache_content_template(), so httpd_squid_script_t can't be used here.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
