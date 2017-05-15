Message-ID: <1494853077.11971.2.camel@tycho.nsa.gov>
Subject: Re: Possible use after free in selabel_subs_init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>, Nicolas Iooss
 <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Mon, 15 May 2017 08:57:57 -0400
In-Reply-To: <CAFftDdpBL2pV5RBbm-upuNZt8mU3d1dbPBE_H2au1MP7euxPgA@mail.gmail.com>
References: <CAJfZ7=kc+bS6b6Owk-d8aiFp8sWXs1MOZ+=V9mBmgcU3QVX=iw@mail.gmail.com>
 <CAFftDdpBL2pV5RBbm-upuNZt8mU3d1dbPBE_H2au1MP7euxPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-12 at 15:02 -0700, William Roberts wrote:
> 
> 
> On Fri, May 12, 2017 at 1:26 PM, Nicolas Iooss <nicolas.iooss@m4x.org
> > wrote:
> > Hi,
> > 
> > Currently libselinux/src/label.c defines selabel_subs_init() like
> > this [1]:
> > 
> >     struct selabel_sub *selabel_subs_init(/* ... */)
> >     {
> >         /* ... */
> >         while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
> >             /* ... allocate and fill "sub" ... */
> >             sub->next = list;
> >             list = sub;
> >         }
> > 
> >         if (digest_add_specfile(digest, cfg, NULL, sb.st_size,
> > path) < 0)
> >             goto err;
> > 
> >     out:
> >         fclose(cfg);
> >         return list;
> >     err:
> >         if (sub)
> >             free(sub->src);
> >         free(sub);
> >         goto out;
> >     }
> > 
> > When digest_add_specfile() fails, sub is freed (in the err label),
> > but
> > as list=sub, it means that the return value, list, is freed. This
> > leads to a use-after-free when this value is used.
> > 
> > What should selabel_subs_init() do (and return) when
> > digest_add_specfile() fails?
> > 
> > Nicolas
> > 
> > [1] https://github.com/SELinuxProject/selinux/blob/9cc62ce35d099acf
> > 7897b6259228479737521709/libselinux/src/label.c#L94
> > 
> > 
> 
> From what I can tell, and I may be wrong, is that the only callers
> are from init() in label_file.c. So the first two failure returns
> where it returns list,
> list i think would be NULL there. Which makes sense since the first
> iteration, the linked list next pointer would be NULL. I think we
> would want to free
> the whole list and return NULL and have callers check for NULL. This
> seems like a fatal error path. But I am wrong frequently :-)

Looks like the logic for appending to an existing list provided by the
caller is a legacy of the original code, obsoleted by 
fd56c5230cea6b81fbe74d1d0a228936a6797923 when dist_subs was split out. 
In which case we don't need to pass in list at all; it will always be
NULL as you say.  However, we should distinguish error cases; it should
not be a fatal error if the path doesn't exist (the subs configurations
are optional), but memory allocation or other failures likely should be
fatal.
