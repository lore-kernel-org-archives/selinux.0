MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: peersid capability support
Date: Wed, 5 Dec 2007 14:00:18 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455FAD@exchange.columbia.tresys.com>
In-Reply-To: <1196881138.16006.79.camel@moss-spartans.epoch.ncsc.mil>
References: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com> <1196881138.16006.79.camel@moss-spartans.epoch.ncsc.mil>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Joshua Brindle" <jbrindle@tresys.com>,
        <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> This happens on the success path too - thereby clearing the policycaps
> before they are written out to the kernel policy file.  Which would
> explain why Paul doesn't see anything kernel side.
> 
> If dismod/dispol had support for displaying the bitmap, you'd be able
> to see that more easily...
> 
>>  	free(state.typemap);
>>  	free(state.boolmap);
>>  	return retval;

Yes, I realized that earlier today.  I'm actually in the process of
packing up an updated patch set that includes dismod/dispol support.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
