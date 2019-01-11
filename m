Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACDC43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531DA20879
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 02:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PFSM4NWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfAKCon (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:44:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46556 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfAKCon (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 21:44:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id y14so9741567lfg.13
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 18:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5bs79uMTiQGQS8mM81p4ZxEjwh++Wjj5W0EFvt1DQ14=;
        b=PFSM4NWaFZqG521K6D0on5pQKT0cQ1Xw8CEKEsTFByEG1u9nL/0hPzqKyKhNObMR7J
         p6gZosxqWKhcrbgHjdV6OFUwbn4wpF6Eh34XZO46j0MSKB+q1PNtdzykS92a19rx8BJC
         iuAx/0UXsQZ9rIPA9+LyQwDoFwcp45onchVmA8HA/Ug9MvmRTTWxuy1rpvzbPXUY3pEv
         Qv7m8ITTcud1m5XLOaAn6fdjxZ4rTK8A1DNPtYYhxVmNluT8Xjn6MLLU/79/AHfCiZR/
         bwcMUcRWs+lmOEBtaxRUzZ4PfO6xnZB1Ko3q0ynBnrHus2HY7ZDfmrb7QybL8oqJrIr+
         w09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5bs79uMTiQGQS8mM81p4ZxEjwh++Wjj5W0EFvt1DQ14=;
        b=QzWRwb8PtafitSDv3fuWpngJRJRrK1AMr20mLAhUKrx7qaE2mB8KnQbjkuy7GwW07q
         MrHkWsxI79av7XbG/whywE58O8YJcx8MoZp6B7oY1+6W5jISYXKYSxnz0DLu9oSPc5jD
         hvWN5oHlzh9BdW8JvVzPhLkpxRTb2HXtiGtJ6IG4ydcsOfdcHIHKG01eDR71Js06tBtD
         4Klnq8KvL59j5eJ+oBBmk1rqxWRTR9ZFK+ZxOFRdbqI+SgE71kkj+xUz+Jj9KPlSfx56
         4qFUkZfVIgy4JYdjl2lCG6F21Jw7UPa90+kUdRbyLVYiqS1MTw5p+8ti0QSgELwfO04P
         Gqng==
X-Gm-Message-State: AJcUukevzjguWv3e1PvHsPBvvoFcqgJjmqkSH2Hyo2NbjPZet4AC8giT
        P/wMBkc/LEzp2/vrMuLhl99ZuvmYOFmk5VMkDe2p
X-Google-Smtp-Source: ALg8bN4NT4Tb40p2qARK6rn7u69+4VfZyJs/+PXRy/xhtc21Yx3enacskuNJhjZStWyLL9TwLOfuufqu8NdBLeerEis=
X-Received: by 2002:a19:6719:: with SMTP id b25mr6616896lfc.38.1547173245974;
 Thu, 10 Jan 2019 18:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20190109162830.8309-1-omosnace@redhat.com> <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov> <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov> <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov>
In-Reply-To: <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 21:20:34 -0500
Message-ID: <CAHC9VhRWfaju_pL8US=gyTn-qu+iF1Nc_71OqGMiJSY6bOwg5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 10, 2019 at 2:36 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/10/19 12:54 PM, Casey Schaufler wrote:
> > Resending after email configuration repair.
> >
> > On 1/10/2019 6:15 AM, Stephen Smalley wrote:
> >> On 1/9/19 5:03 PM, Casey Schaufler wrote:
> >>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
> >>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
> >>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> >>>>>> Changes in v2:
> >>>>>> - add docstring for the new hook in union security_list_options
> >>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
> >>>>>>      implemented
> >>>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnac=
e@redhat.com/T/
> >>>>>>
> >>>>>> This series adds a new security hook that allows to initialize the=
 security
> >>>>>> context of kernfs properly, taking into account the parent context=
. Kernfs
> >>>>>> nodes require special handling here, since they are not bound to s=
pecific
> >>>>>> inodes/superblocks, but instead represent the backing tree structu=
re that
> >>>>>> is used to build the VFS tree when the kernfs tree is mounted.
> >>>>>>
> >>>>>> The kernfs nodes initially do not store any security context and r=
ely on
> >>>>>> the LSM to assign some default context to inodes created over them=
.
> >>>>>
> >>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the u=
sual
> >>>>> and expected filesystem behavior?
> >>>>
> >>>> sysfs / kernfs didn't support xattrs at all when we first added supp=
ort for setting security contexts to it, so originally all sysfs / kernfs i=
nodes had a single security context, and we only required separate storage =
for the inodes that were explicitly labeled by userspace.
> >>>>
> >>>> Later kernfs grew support for trusted.* xattrs using simple_xattrs b=
ut the existing security.* support was left mostly unchanged.
> >>>
> >>> OK, so as I said, this seems like a bug in kernfs.
> >>>
> >>>>
> >>>>>
> >>>>>> Kernfs
> >>>>>> inodes, however, allow setting an explicit context via the *setxat=
tr(2)
> >>>>>> syscalls, in which case the context is stored inside the kernfs no=
de's
> >>>>>> metadata.
> >>>>>>
> >>>>>> SELinux (and possibly other LSMs) initialize the context of newly =
created
> >>>>>> FS objects based on the parent object's context (usually the child=
 inherits
> >>>>>> the parent's context, unless the policy dictates otherwise).
> >>>>>
> >>>>> An LSM might use information about the parent other than the "conte=
xt".
> >>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the par=
ent
> >>>>> to determine whether the Smack label of the new object should be ta=
ken
> >>>>> from the parent or the process. Passing the "context" of the parent=
 is
> >>>>> insufficient for Smack.
> >>>>
> >>>> IIUC, this would involve switching the handling of security.* xattrs=
 in kernfs over to use simple_xattrs too (so that we can store multiple suc=
h attributes), and then pass the entire simple_xattrs list or at least anyt=
hing with a security.* prefix when initializing a new node or refreshing an=
 existing inode.  Then the security module could extract any security.* att=
ributes of interest for use in determining the label of new inodes and in r=
efreshing the label of an inode.
> >>>
> >>> Right. But I'll point out that there is nothing to prevent an
> >>> LSM from using inode information outside of the xattrs (e.g. uids)
> >>> to determine the security state it wants to give a new object.
> >>
> >> If that's a real concern, the hook could pass the ia_iattr structure i=
n addition to the simple_xattrs list and the security module could use any =
inode attributes it likes in making the decision.  Effectively it would be =
passing the entire kernfs_iattrs structure, but probably not directly since=
 that definition is presently private to kernfs.
> >
> > Yes, it's a real concern. And no, just passing all of the kernfs intern=
al data
> > out in j-random formats does not pass muster. Al Viro was commenting th=
e other
> > day on how bad the LSM infrastructure interfaces are. The original prop=
osal here
> > is already big, cluttered and inadequate. Adding more to it to make up =
for its
> > shortcomings should be sending up red flags
>
> I don't quite see how the original patch set or hook can be called big
> and cluttered.  Switching the handling of security xattrs in kernfs to
> use simple_xattrs (a natural and seemingly straightforward cleanup) and
> passing the entire simple_xattrs list to the hook interface would allow
> you to support SMACK64TRANSMUTE, which was the one actual inadequacy you
> identified.  You claim that someone might need/want the parent uid/gid
> too, but there are no in-tree security modules that do so nor any
> submitted AFAIK, and if that situation arises, all we need to do to
> support it is to add the iattrs.  Obviously they can all be wrapped up
> in some larger structure if desired. At that point the security modules
> would have access to all of the inode attributes supported by kernfs.

I'm with Stephen on this; if Ondrej changes it over to simple_xattrs
as described above so that Smack would have what it needs, I don't see
why we should hold off on this.

Everything we are talking about is a kernel internal issue, we can
change it as needed to take into account new LSMs or new functionality
in existing LSMs.

Ondrej, a gentle reminder that it would be nice to have a simple
selinux-testsuite test to make sure we are labeling
kernfs-based/cgroup files correctly.

--=20
paul moore
www.paul-moore.com
