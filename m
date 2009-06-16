Subject: Re: type bounds audit messages
From: Eric Paris <eparis@redhat.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, sgrubb@redhat.com,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4A36EAA7.5090408@ak.jp.nec.com>
References: <1244730288.10762.120.camel@localhost.localdomain>
	 <4A31A33F.2040504@ak.jp.nec.com>
	 <1244807594.18947.62.camel@localhost.localdomain>
	 <4A35F091.6000202@ak.jp.nec.com>
	 <1245071835.3247.57.camel@dhcp231-142.rdu.redhat.com>
	 <1245074488.4078.18.camel@localhost.localdomain>
	 <4A36EAA7.5090408@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 10:26:46 -0400
Message-Id: <1245162406.2848.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-16 at 09:43 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:

> For example, how do you feel the example on security_compute_av() time?
> 
> type=SELINUX_INFO msg=audit(1245046106.725:65):       \
>   op=security_compute_av masked=bounds                \
>   scontext=system_u:system_r:user_webapp_t:s0         \
>   tcontext=system_u:object_r:httpd_sys_content_t:s0   \
>   tclass=file { setattr write }

I feel good for all but the { setattr write }

It's a new message, we have no parsers which need the old format, how
would others feel about

perm="setattr,write"   ?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
