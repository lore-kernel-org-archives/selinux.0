Date: Fri, 13 Sep 2002 08:25:29 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: apache configuration etc
Message-ID: <20020912222529.GA4111@snoopy.apana.org.au>
References: <200209122135.40681.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209122135.40681.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 12, 2002 at 09:35:40PM +0200, Russell Coker wrote:
> I think that the Apache policy should be macroised.

For a good example of why it should be macroised, have a look at
the openca stuff.

I seem to recall copying large parts of the apache config, but
it should really be shared instead.

I think the same thing would apply to other CGI scripts.

Especially, for instance, CGI scripts that require passwords
to access SQL based databases, etc.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
