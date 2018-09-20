Date: Thu, 20 Sep 2018 11:44:58 +0200
From: Florian Westphal <fw@strlen.de>
To: Christian =?iso-8859-15?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: fw@strlen.de, casey@schaufler-ca.com, pablo@netfilter.org,
 kadlec@blackhole.kfki.hu, davem@davemloft.net,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
 serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org
Message-ID: <20180920094458.6hwaw3vgfsxvcgb4@breakpoint.cc>
References: <20180919231402.4482-1-cgzones@googlemail.com>
 <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <20180920085048.tps2v4jkko7zjav4@breakpoint.cc>
 <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CAJ2a_DfGCRXaH9BkBj=0R1Cr3jiHQHgq-pU2HGuWudvWCSKLQg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Christian Göttsche <cgzones@googlemail.com> wrote:
> > Fixes should go into nf.git whereas feature goes to nf-next.git.
> 
> No, that should not be a unroll fix.
> Currently there are no objects registered by the main nf_tables
> module, so for nft_secmark_obj_type I had to introduce this new logic.

I see, ok.

> > > > +   if (err) {
> > > > +           if (err == -EINVAL)
> > > > +                   pr_notice_ratelimited("invalid security context \'%s\'\n", priv->ctx);
> > > > +           else
> > > > +                   pr_notice_ratelimited("unable to convert security context \'%s\': %d\n", priv->ctx, -err);
> > > > +           return;
> > > > +   }
> >
> > Please remove these printks(), they do not really help as user can't
> > take any action anyway.
> 
> Aren't they helpful?
> "invalid security context" can pop up if someone supplies an invalid
> SELinux context (nft add secmark inet filter sshtag
> \"this_is_invalid\") and uses it

Can't that be caught at ->init() time?
We can then reject this via plain -EINVAL.

No need for printk because caller knows which expression/object caused
the error.

> "unable to convert security context" can pop up if no LSM is enabled

Can that be done at ->init() time when we can still reject the (invalid)
rule?

> "unable to map security context" should never happen, but one never knows

Ok, but what is user supposed to do?
This just causes perpetual spew of warnings in the kernel ring buffer.

> "unable to obtain relabeling permission" can pop up if e.g. the
> SELinux permission "kernel_t ssh_server_packet:packet relabelto" is
> missing

Makes sense, but this will need to be a plain
return -EPERM, this function can only be used in process context.
