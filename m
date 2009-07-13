Subject: Re: [PATCH -v2] SELinux: Convert avc_audit to use lsm_audit.h
From: Eric Paris <eparis@redhat.com>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
In-Reply-To: <1247236264.2226.3.camel@Ares>
References: <1247171811.2276.13.camel@Ares>
	 <1247172234.2927.4.camel@dhcp235-23.rdu.redhat.com>
	 <1247236264.2226.3.camel@Ares>
Content-Type: text/plain
Date: Sun, 12 Jul 2009 21:36:30 -0400
Message-Id: <1247448990.3068.18.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-10 at 10:31 -0400, Thomas Liu wrote:
> Convert avc_audit in security/selinux/avc.c to use lsm_audit.h,
> for better maintainability and for less code duplication.
> 
>  - changed selinux to use common_audit_data instead of
>    avc_audit_data
>  - eliminated code in avc.c and used code from lsm_audit.h instead.
> 
> I have tested to make sure that the avcs look the same before and
> after this patch.
> 

> -			if (a->u.net.netif > 0) {
> -				struct net_device *dev;
> -
> -				/* NOTE: we always use init's namespace */
> -				dev = dev_get_by_index(&init_net,
> -						       a->u.net.netif);
> -				if (dev) {
> -					audit_log_format(ab, " netif=%s",
> -							 dev->name);
> -					dev_put(dev);
> -				}
> -			}
> -			break;
> -		}
> -	}
> -	audit_log_format(ab, " ");
> -	avc_dump_query(ab, ssid, tsid, tclass);
> -	audit_log_end(ab);

hmmmm, forgot ssid and tsid....

Although that doesn't give away the panic to me right offhand....

> +	a->selinux_audit_data.avd = avd;
> +	a->selinux_audit_data.tclass = tclass;
> +	a->selinux_audit_data.requested = requested;
> +	a->lsm_pre_audit = avc_audit_pre_callback;
> +	a->lsm_post_audit = avc_audit_post_callback;
> +	common_lsm_audit(a);
>  }

Are you certain you tested this Tomas and weren't just running your old
kernel both times?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
