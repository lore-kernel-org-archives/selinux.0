Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09Mjnfo026217
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 17:45:49 -0500
Received: by mail-qe0-f42.google.com with SMTP id b4so3830513qen.29
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 14:45:48 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Thu, 09 Jan 2014 17:45:45 -0500
Message-ID: <1586626.0cAE0OtpOI@sifl>
In-Reply-To: <52CF1A53.9080501@redhat.com>
References: <52CF1A53.9080501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, January 09, 2014 04:53:23 PM Daniel J Walsh wrote:
> We would like to change
> 
> sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)
> 
> to something like
> 
> sid file_labels         gen_context(system_u:object_r:invalid_label_t,s0)

Hmmm, this is odd ... I'm quickly grep'ing the kernel source and while I can 
find the file initial sid, I can't seem to find the file_labels initial sid 
used anywhere ...

Are you talking about the file initial sid?

> Since explaining to someone that a file without a label is file_t, but if it
> has a label that the kernel does not understand it is labeled as
> unlabeled_t. A file with a label is unlabeled_t????  While a file without a
> label is file_t.

That is annoying.  I personally think that unlabeled_t is the right choice for 
objects (files, packets, etc.) without any label information.  If there is 
some label present, even if it is invalid (e.g. MLS label on a non-MLS sytem), 
then it should have a different label, invalid_t?

> #
> # unlabeled_t is the type of unlabeled objects.
> # Objects that have no known labeling information or that
> # have labels that are no longer valid are treated as having this type.
> #
> 
> #
> # file_t is the default type of a file that has not yet been
> # assigned an extended attribute (EA) value (when using a filesystem
> # that supports EAs).
> #
> 
> These two type definitions seem to conflict, with file_t winning at least on
> systems that support XAttrs.

If I had to guess I think this might be due to some differences in the file 
initial sid and some default handling with the genfs code.  Eric or Stephen 
can probably explain this better than I can right now.

> I would guess a better fix would be to change the kernel to handle the case
> where an object is unlabeled_t one way and if it is labeled and the kernel
> does not understand the label differently.
> 
> sid invalid_file_labels gen_context(system_u:object_r:invalid_label_t,s0)
> 
> Opinions....

Makes sense to me.  Just two suggestions ... First, I think the MLS field 
should probably be "mls_systemhigh" and not "s0"; while it is different from 
unlabeled_t, I think we want to treat it the same from a MLS perspective.  
Second, make the invalid label a bit more general and not tied just to files, 
e.g. invalid_t, so we could use it for other objects if needed.

sid invalid_label gen_context(system_u:object_r:invalid_t,mls_systemhigh)

-- 
paul moore
www.paul-moore.com
