From: Paul Moore <paul.moore@hp.com>
To: Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Thu, 20 Sep 2007 14:58:29 -0400
Cc: James Morris <jmorris@namei.org>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
References: <27C0723414C58546B4084C2F17BE052A36655B@chaos.tcs.tcs-sec.com>
In-Reply-To: <27C0723414C58546B4084C2F17BE052A36655B@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709201458.29269.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 20 2007 2:50:55 pm Chad Hanson wrote:
> I agree performance could be an issue. I would suggest these checks are
> performed based on value /counter instead of the presence of labeled
> networking.

Personally I like the idea of using a counter/flag/toggle/etc to 
enable/disable the checks but I believe there might be push back due to the 
added user configuration burden (even though it would be rather small).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
