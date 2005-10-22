Message-ID: <435A3B6C.4050408@cornell.edu>
Date: Sat, 22 Oct 2005 09:15:24 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL 5 ] Pass key to sepol
References: <435A394B.9010304@cornell.edu>
In-Reply-To: <435A394B.9010304@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> -	if (iface_from_record(policydb, &iface, data) < 0)
> +	rc = sepol_iface_query(p, key, &query_response);
> +	if (rc < 0) 
>  		goto err;
>  
> -	rc = sepol_iface_get_context(
> -		p, data, 
> -		&ifcon_str, &ifcon_str_len,
> -		&msgcon_str, &msgcon_str_len);
> -	if (rc < 0) 
> +	if (iface_from_record(policydb, &iface, data) < 0)
>  		goto err;
>  
>  	else if (rc != STATUS_NODATA) {
>   

This is a rather stupid bug... pasted in wrong place.
Will fix in the next patch... [ SEPOL 6 ]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
