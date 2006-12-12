Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: <selinux@tycho.nsa.gov>
Cc: <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: Labeling traffic over loopback
Date: Tue, 12 Dec 2006 10:00:57 -0600
Message-ID: <000a01c71e06$b6d11020$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following describes a proposal to label traffic over loopback
by using a bit in the sk_buff structure. We have:

struct sk_buff {
...
        struct  sec_path        *sp;
...
        __u8                    pkt_type:3,
                                fclone:2,
                                ipvs_property:1;
...
}

We could use an additional bit (local_label) to denote that
"sp" holds the source label sid (no blob, so no lifecycle mgmt).

What do people think?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
