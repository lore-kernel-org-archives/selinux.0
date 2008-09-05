Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8593MRS023090
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 05:03:22 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8593Mfb001540
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:03:22 GMT
Date: Fri, 5 Sep 2008 19:03:21 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 09/14] netlabel: Add functionality to set the
 security attributes of a packet
In-Reply-To: <20080903004947.15669.68884.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051902050.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004947.15669.68884.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -117,6 +117,7 @@ struct sk_security_struct {
>  		NLBL_UNSET = 0,
>  		NLBL_REQUIRE,
>  		NLBL_LABELED,
> +		NLBL_REQSKB
>  	} nlbl_state;
>  #endif
>  };

Might be nice to include a comma after that if you update the patches.


Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
