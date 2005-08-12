Subject: Re: [PATCH] fix order of error checking in libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050812192231.GA7053@sergelap.austin.ibm.com>
References: <20050812192231.GA7053@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 12:33:39 -0400
Message-Id: <1123864419.23483.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-12 at 14:22 -0500, serue@us.ibm.com wrote:
> The following patch fixes a bug found by Coverity in libsepol:
> 
> 	In write.c, a check for items==0 is done after a goto out: if
> 	items!=1, resulting in dead code, and rc==-1 when items==0
> 	(which I assume is not intended).
> 
> thanks,
> -serge
> 
> Index: src/write.c
> ===================================================================
> --- src.orig/write.c
> +++ src/write.c
> @@ -567,10 +567,9 @@ static int cond_write_av_list(policydb_t
>  	
>  	buf[0] = cpu_to_le32(len);
>  	items = put_entry(buf, sizeof(uint32_t), 1, fp);
> -	if (items != 1)
> -		goto out;
> -	if (items == 0) {
> -		rc = 0;
> +	if (items != 1) {
> +		if (items == 0)
> +			rc = 0;
>  		goto out;
>  	}

Actually, I think what was intended here was:
	if (items != 1)
		goto out;
	if (len == 0) {
		rc = 0;
		goto out;
	}

items is the number of successfully written items, so anything other
than 1 at that point is indeed an error, whereas len may be 0, in which
case we can skip the list loop (not that there is any harm in just
falling through to it).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
