From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v4 1/3] [SELinux] Add a capabilities bitmap to SELinux policy version 22
Date: Wed, 10 Oct 2007 14:31:57 -0400
Cc: selinux@tycho.nsa.gov
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net> <20071005193245.28034.67610.stgit@flek.americas.hpqcorp.net> <1192040194.2687.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1192040194.2687.75.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710101431.57330.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 October 2007 2:16:34 pm Stephen Smalley wrote:
> On Fri, 2007-10-05 at 15:32 -0400, Paul Moore wrote:
> > @@ -1304,6 +1307,9 @@ int security_load_policy(void *data, size_t len)
> >  			return -EINVAL;
> >  		}
> >  		policydb_loaded_version = policydb.policyvers;
> > +		selinux_policycap_netpeer =
> > +		  ebitmap_get_bit(&policydb.policycaps,
> > +				  POLICYDB_CAPABILITY_NETPEER);
> >  		ss_initialized = 1;
> >  		seqno = ++latest_granting;
> >  		LOAD_UNLOCK;
>
> Only handles the initial policy load case, not reloads.

So it does, thanks.  I just added the same assignment further down in the 
security_load_policy() function to handle the reload case.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
