Message-ID: <45082058.5040106@tresys.com>
Date: Wed, 13 Sep 2006 11:14:32 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <45001F1A.3080004@redhat.com>	 <1157726159.31695.83.camel@moss-spartans.epoch.ncsc.mil>	 <45019C39.2090008@redhat.com> <1157747116.31695.223.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157747116.31695.223.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-09-08 at 12:37 -0400, Daniel J Walsh wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2006-09-07 at 09:31 -0400, Daniel J Walsh wrote:
>>>   
>>>> Have newrole ignore sigpipe so it gives correct error message when 
>>>> flooded with 4000 character security context.
>>>>     
>>> I'm a little unclear on this one, although I did find a bug report about
>>> it (which would be helpful to identify in the patch posting in the
>>> future when it applies for easy reference), at
>>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203801
>>>
>>> If I read that one correctly, the SIGPIPE is actually happening when
>>> libselinux tries to write the context to the setrans socket, because the
>>> daemon is dropping the connection immediately upon getting the header
>>> with such a large length (more generally, any failure in the daemon
>>> before reading the entire request could lead to this).  So that could
>>> affect any user of libselinux, not just newrole, right?
>>>
>>> Looking around a bit, I see that if we changed the use of writev() in
>>> libselinux to instead use sendmsg() with an explicit MSG_NOSIGNAL flag,
>>> we could avoid having such failures generate SIGPIPE altogether.  Then
>>> we would just get an error return and have the usual fallback handling.
>>>   
>> That sounds like a better solution.
> 
> Possible patch below.  Changes:
> 1) Collect up the entire request into a single msg and send it once.
> 2) Use sendmsg with MSG_NOSIGNAL rather than writev.
> 
> Can anyone explain what data2 is for?  It is always NULL at present
> AFAICS.
> 
> Index: libselinux/src/setrans_client.c
> ===================================================================
> RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setrans_client.c,v
> retrieving revision 1.8
> diff -u -p -r1.8 setrans_client.c
> --- libselinux/src/setrans_client.c	29 Jun 2006 18:21:05 -0000	1.8
> +++ libselinux/src/setrans_client.c	8 Sep 2006 20:18:07 -0000
> @@ -58,11 +58,12 @@ static int setransd_open(void)
>  static int
>  send_request(int fd, uint32_t function, const char *data1, const char *data2)
>  {
> -	struct iovec req_hdr[3];
> +	struct msghdr msgh;
> +	struct iovec iov[5];
>  	uint32_t data1_size;
>  	uint32_t data2_size;
> -	struct iovec req_data[2];
> -	ssize_t count;
> +	ssize_t count, expected;
> +	unsigned int i;
>  
>  	if (fd < 0)
>  		return -1;
> @@ -75,28 +76,27 @@ send_request(int fd, uint32_t function, 
>  	data1_size = strlen(data1) + 1;
>  	data2_size = strlen(data2) + 1;
>  
> -	req_hdr[0].iov_base = &function;
> -	req_hdr[0].iov_len = sizeof(function);
> -	req_hdr[1].iov_base = &data1_size;
> -	req_hdr[1].iov_len = sizeof(data1_size);
> -	req_hdr[2].iov_base = &data2_size;
> -	req_hdr[2].iov_len = sizeof(data2_size);
> -
> -	while (((count = writev(fd, req_hdr, 3)) < 0) && (errno == EINTR)) ;
> -	if (count != (sizeof(function) + sizeof(data1_size) +
> -		      sizeof(data2_size))) {
> -		return -1;
> -	}
> +	iov[0].iov_base = &function;
> +	iov[0].iov_len = sizeof(function);
> +	iov[1].iov_base = &data1_size;
> +	iov[1].iov_len = sizeof(data1_size);
> +	iov[2].iov_base = &data2_size;
> +	iov[2].iov_len = sizeof(data2_size);
> +	iov[3].iov_base = (char *)data1;
> +	iov[3].iov_len = data1_size;
> +	iov[4].iov_base = (char *)data2;
> +	iov[4].iov_len = data2_size;
> +	memset(&msgh, 0, sizeof(msgh));
> +	msgh.msg_iov = iov;
> +	msgh.msg_iovlen = sizeof(iov)/sizeof(iov[0]);
> +
> +	expected = 0;
> +	for (i = 0; i < sizeof(iov)/sizeof(iov[0]); i++)
> +		expected += iov[i].iov_len;
>  
> -	req_data[0].iov_base = (char *)data1;
> -	req_data[0].iov_len = data1_size;
> -	req_data[1].iov_base = (char *)data2;
> -	req_data[1].iov_len = data2_size;
> -
> -	while (((count = writev(fd, req_data, 2)) < 0) && (errno == EINTR)) ;
> -	if (count < 0 || (uint32_t) count != (data1_size + data2_size)) {
> +	while (((count = sendmsg(fd, &msgh, MSG_NOSIGNAL)) < 0) && (errno == EINTR)) ;
> +	if (count < 0 || count != expected)
>  		return -1;
> -	}
>  
>  	return 0;
>  }
> 
> 

Thanks, merged.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
