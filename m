Date: Mon, 30 Mar 2009 15:01:21 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090330200121.GD9992@Sun.COM>
References: <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D10FC1.3000103@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 30, 2009 at 11:30:25AM -0700, Jarrett Lu wrote:
> On 03/30/09 10:37, Stephen Smalley wrote:
> >I'm not sure if this conflicts with what you are saying, but the DOI
> >should merely identify the (externally) agreed-upon network label space
> >for the data to be shared between the communicating systems.  [...]

Right now that's the best we can do, and CALIPSO does nothing to improve
this situation.

> As Casey and others pointed out, a lot more information about a 
> communicating peer is needed in order to be able to translate a label 
> and other security attributes. People have tried this in 90's. 
> Apparently the solution is no longer in use today. Maybe we can do 
> something better 15 years later. The first step is to figure out how 
> much information is needed and then look into how to get this info 
> across securely. GSS_SEC may be able to help us. To make NFSv4 work, 
> only TCP is needed. So peer information is needed per session vs. per 
> packet, I believe. Evidently, there is more work to do in figuring this 
> all out.

I believe that certificate extensions and Kerberos V authorization-data
could be used to ensure that the client and server both know the correct
"label encodings" for their shared DOIs.

To specify such a thing would be easy: allocate cert ext OID (for PKIX
certs) and authz-data ID (for Kebreros V) and specify the contents of
the extension, which could be the DER encoding of:

	DOI-SPEC ::= SEQUENCE {
		doi INTEGER (0..MAX),
		label-encodings-uri UTF8STRING -- contraint: MUST be a URI
	}

	DOI-SPECS ::= SEQUENCE SIZE (1..MAX) OF DOI-SPEC;

I.e., a sequence of {DOI number, label encodings URI}.

Then define the format of the document referenced by the label encodings
URI.  That format should cover MLS and DTE DOI types.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
