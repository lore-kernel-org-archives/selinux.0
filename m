MIME-Version: 1.0
References: <20180923091611.19815-1-cgzones@googlemail.com>
 <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
In-Reply-To: <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 23 Sep 2018 17:31:16 +0200
Message-ID: <CAJ2a_DfCmbFmpTngFnXzYy07gvEzN5UhAhrE8Cd8PowevrLUNw@mail.gmail.com>
To: fw@strlen.de
Cc: pablo@netfilter.org, kadlec@blackhole.kfki.hu, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
 serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

> > +struct nft_secmark {
> > +     char ctx[NFT_SECMARK_CTX_MAXLEN];
> > +     int len;
> > +     u32 secid;
> > +};
>
> Can you change this to:
>
> struct nft_secmark {
>         u32 secid;
>         char *ctx;
> };

Does the nla_policy struct needs an update too? (regarding then .len member)

+static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
+        [NFTA_SECMARK_CTX] = { .type = NLA_STRING, .len =
NFT_SECMARK_CTX_MAXLEN },
+}

NFT_SECMARK_CTX_MAXLEN might be dropped then..
