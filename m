Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62Mv1L2027941
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 18:57:01 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n62MvbSI029531
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 22:57:37 GMT
Date: Fri, 3 Jul 2009 08:56:59 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Justin P. Mattock" <justinmattock@gmail.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SElinux: Fix some typos.
In-Reply-To: <1246556775-8942-2-git-send-email-justinmattock@gmail.com>
Message-ID: <alpine.LRH.2.00.0907030850500.10242@tundra.namei.org>
References: <1246556775-8942-1-git-send-email-justinmattock@gmail.com> <1246556775-8942-2-git-send-email-justinmattock@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Jul 2009, Justin P. Mattock wrote:

> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> 
> Fix some typos in some comments.

> -/* The file system's label must be initialized prior to use. */
> +/* The filesystems label must be initialized prior to use. */

Your adding grammertical error's.

> -	 * Note that the setting of hard limits (even to lower them) can be
> +	 * Note: That the setting of hard limits (even to lower them) can be

Please get this patch reviewed by an English speaker.

>   * Description:
>   * Call the NetLabel mechanism to get the security attributes of the given
> - * packet and use those attributes to determine the correct context/SID to
> - * assign to the packet.  Returns zero on success, negative values on failure.
> + * packet and use those attributes to determine the correct context/SID to be
> + * assigned to the packet.  Returns zero on success, negative values on failure.

Eschew the active voice?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
