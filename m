Message-ID: <45DF00AB.1080604@trustedcs.com>
Date: Fri, 23 Feb 2007 08:56:43 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Remove init_context_translations() from libselinux
References: <1172078429.14363.279.camel@moss-spartans.epoch.ncsc.mil>	 <45DDBFB0.9040401@redhat.com>  <45DDCAA4.1070103@trustedcs.com> <1172234630.14363.475.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172234630.14363.475.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-02-22 at 10:53 -0600, Darrel Goeddel wrote:
>> Daniel J Walsh wrote:
>>> Stephen Smalley wrote:
>>>> I think we've talked about this before, but never followed through.
>>>> Is there any reason to retain the init_context_translations() function
>>>> in libselinux, which sends a SETRANS_INIT message to mcstransd, gets a
>>>> response, and discards it?  Can we drop it and the call to it from the
>>>> library constructor/initializer?
>>>>
>>>>   
>>> Ok with me.
>> Removal looks OK to me.  It used to be that a failure would cause
>> translations to be disabled, but it is now vestigial.
> 
> On second look, we need to retain the function to set mls_enabled for
> later use, but we can drop the part that communicates with mcstransd.
> Patch below.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Darrel Goeddel <dgoeddel@trustedcs.com>

> Index: libselinux/src/setrans_client.c
> ===================================================================
> --- libselinux/src/setrans_client.c	(revision 2263)
> +++ libselinux/src/setrans_client.c	(working copy)
> @@ -213,29 +213,8 @@
>  
>  hidden int init_context_translations(void)
>  {
> -	int ret, fd;
> -	int32_t ret_val;
> -	char *out = NULL;
> -
>  	mls_enabled = is_selinux_mls_enabled();
> -	if (!mls_enabled)
> -		return 0;
> -
> -	fd = setransd_open();
> -	if (fd < 0)
> -		return fd;
> -
> -	ret = send_request(fd, SETRANS_INIT, NULL, NULL);
> -	if (ret)
> -		goto out;
> -
> -	ret = receive_response(fd, SETRANS_INIT, &out, &ret_val);
> -	free(out);
> -	if (!ret)
> -		ret = ret_val;
> -      out:
> -	close(fd);
> -	return ret;
> +	return 0;
>  }
>  
>  int selinux_trans_to_raw_context(security_context_t trans,
> Index: libselinux/src/setrans_internal.h
> ===================================================================
> --- libselinux/src/setrans_internal.h	(revision 2263)
> +++ libselinux/src/setrans_internal.h	(working copy)
> @@ -2,7 +2,6 @@
>  
>  #define SETRANS_UNIX_SOCKET "/var/run/setrans/.setrans-unix"
>  
> -#define SETRANS_INIT		1
>  #define RAW_TO_TRANS_CONTEXT		2
>  #define TRANS_TO_RAW_CONTEXT		3
>  #define MAX_DATA_BUF			8192
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
