Date: Tue, 10 Dec 2002 09:11:17 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Richard Mayo <rmayo@caci.com>, SELinux@tycho.nsa.gov
Subject: Re: Basic Question
Message-ID: <20021209221117.GB19816@snoopy.apana.org.au>
References: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com> <200212091924.50565.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212091924.50565.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 09, 2002 at 07:24:50PM +0100, Russell Coker wrote:
> In all other cases of access being denied the message will be logged in 
> enforcing mode (subject to the usual rate limit).

Just in case Russell didn't make it clear, in enforcing mode
there is a rate limit; from the comment for avc_ratelimit:

/* 
 * This enforces a rate limit: not more than one kernel message
 * every 5secs to make a denial-of-service attack impossible.
 */ 

This only takes affect in enforcing mode:

static inline int check_avc_ratelimit(void)  
{
        if (selinux_enforcing)
                return avc_ratelimit();
        else {
                /* If permissive, then never suppress messages. */
                return 1;
        }
}

Over messages are simply discarded:

void avc_audit(...)
{
   ...

        if (!check_avc_ratelimit())
                return;

   ...

	print avc message here
}
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
