Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RFOkWt025488
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 10:24:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9RFOjIE012722
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 15:24:45 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9RFOi1J012719 for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 15:24:44 GMT
Subject: Re: question about pam_selinux multiple option
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
References: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
Content-Type: text/plain
Message-Id: <1067268273.18818.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 27 Oct 2003 10:24:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-10-25 at 00:44, Yuichi Nakamura wrote:
> When I saw the man page of pam_selinux, 
> there is a option "multiple". I think it is convenient.
> However, in pam-selinux.patch, the code about "multiple" is commented out,like this.
> +    /*    if (strcmp(argv[i], "multiple") == 0) {
> +      multiple = 1;
> +      }*/
> When I enabled it, the "multiple" option seemed to work.
> Why is it commented out ? 
> Will "multiple" option be enabled in the future?

I don't see any reason to omit the code either, as you can always just
omit the option in your PAM configuration if you don't want that
functionality.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
