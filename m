Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAI17PSr017512
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 20:07:25 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAI16gKG014107
	for <selinux@tycho.nsa.gov>; Sat, 18 Nov 2006 01:06:42 GMT
Received: by wx-out-0506.google.com with SMTP id t10so1212846wxc
        for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:07:41 -0800 (PST)
Message-ID: <455E5C6C.5010405@kaigai.gr.jp>
Date: Sat, 18 Nov 2006 10:05:48 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 3/5] libselinux: security_class_to_string helper function
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil> <1163714050.15225.134.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1163714050.15225.134.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> A new helper function that converts from class value to class name.  

Do you have a plan to provide 'security_av_perm_to_string()' function?
I like to use them to generate a message in the PostgreSQL extension.

Because generating an error notification and aborting transaction are
integrated in PostgreSQL, it's hard to use general avc_audit() function. :(

Thanks,

> Note that this patch and further patches will apply with -p0 to the
> selinux directory, while the two previous patches apply with -p0 to
> selinux/libselinux.
> 
> ---
>  libselinux/include/selinux/selinux.h |    3 ++-
>  libselinux/src/avc.c                 |    8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
