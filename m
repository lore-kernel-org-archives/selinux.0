Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATKmJbO032730
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:48:19 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATKlba4025705
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 20:47:37 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Joy Latten" <latten@austin.ibm.com>
Cc: <redhat-lspp@redhat.com>, <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: [redhat-lspp] Re: labeled ipsec policy
Date: Wed, 29 Nov 2006 14:42:23 -0600
Message-ID: <001701c713f6$e02b11b0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1164812372.25344.41.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I'm not very sure how users will use the SPD labeling.  I suspect that
> they will be labeled with probably the other side's domain type.  For
> example, if httpd_t and mozilla_t are connected, the SPD would be
> mozilla_t on the http machine and httpd_t on the mozilla machine.
>

In the simplest case, you would just have a generic "labeled_ipsec_t" Type
that would be specified for all the spd rules that pertain to labeled-ipsec.
All the different domains that need to use labeled-ipsec would then polmatch
to labeled_ipsec_t.

The SAs will always and automatically be using the originating domain Type.
So, the SA from the client to server would be auto-labeled mozilla_t,
rss_aggregator_t, etc. (on both ends), and the SA from the server to client
would be auto-labeled httpd_t (again on both ends).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
