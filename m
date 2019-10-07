Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F90ECE58C
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CCE2067B
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJGQci (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:32:38 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46764 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQci (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 12:32:38 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9DE6E564722
        for <selinux@vger.kernel.org>; Mon,  7 Oct 2019 18:32:34 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id z6so11538468otb.2
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 09:32:34 -0700 (PDT)
X-Gm-Message-State: APjAAAWxepGZfnb+O0vR9vuh93mgJ9Frm65BzkTDo61SpNinCjK6fEKE
        wInzWpD6tvP8oSElnNzA97HgCccDY+9cRqw/zcI=
X-Google-Smtp-Source: APXvYqw/xGTVI05HC4EgIAf9FLuYZlBAyR/5wd1jOGTJPJRKSewL4zFyYaOThLpumq3bqARxP3hZ7Lz/RR2aQ3MPuCw=
X-Received: by 2002:a9d:e92:: with SMTP id 18mr22251184otj.321.1570465953545;
 Mon, 07 Oct 2019 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190926125218.22958-1-sds@tycho.nsa.gov> <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
 <e96c532b-f469-fd52-ce6d-3e71dc9e145a@tycho.nsa.gov> <pjd4l0thhnr.fsf@redhat.com>
 <CAJfZ7=n09Qz9OxSURCAqdHbMif9qEeRmVq9yk77upDTaDN0M4Q@mail.gmail.com> <8c34a153-c8b4-8b5d-9d49-a82791a59fc6@tycho.nsa.gov>
In-Reply-To: <8c34a153-c8b4-8b5d-9d49-a82791a59fc6@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 7 Oct 2019 18:32:22 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mfeLod9Af++C_EC=qE8=SknDJr6x2V+wNnhyXbXSBfoQ@mail.gmail.com>
Message-ID: <CAJfZ7=mfeLod9Af++C_EC=qE8=SknDJr6x2V+wNnhyXbXSBfoQ@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: call segenxml.py with python3
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct  7 18:32:35 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 7, 2019 at 3:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 9/30/19 3:36 PM, Nicolas Iooss wrote:
> > On Mon, Sep 30, 2019 at 6:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Stephen Smalley <sds@tycho.nsa.gov> writes:
> >>
> >>> On 9/26/19 5:58 PM, Nicolas Iooss wrote:
> >>>> On Thu, Sep 26, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>>>
> >>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/61
> >>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>>>> ---
> >>>>>    python/sepolicy/sepolicy/interface.py | 2 +-
> >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> >>>>> index 583091ae18aa..b1b39a492d73 100644
> >>>>> --- a/python/sepolicy/sepolicy/interface.py
> >>>>> +++ b/python/sepolicy/sepolicy/interface.py
> >>>>> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
> >>>>>            from subprocess import getstatusoutput
> >>>>>        basedir = os.path.dirname(if_file) + "/"
> >>>>>        filename = os.path.basename(if_file).split(".")[0]
> >>>>> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
> >>>>> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
> >>>>>        if rc != 0:
> >>>>>            sys.stderr.write("\n Could not proceed selected interface file.\n")
> >>>>>            sys.stderr.write("\n%s" % output)
> >>>>
> >>>> Considering that Python's "command" module was removed in Python 3
> >>>> (according to https://docs.python.org/2/library/commands.html), and
> >>>> that Python 3's subprocess.getstatusoutput() supports using a list of
> >>>> arguments instead of a string, it seems better to change this code to
> >>>> something like:
> >>
> >> I think this is not correct:
> >>
> >>      Execute the string 'cmd' in a shell with 'check_output' and
> >>      return a 2-tuple (status, output). The locale encoding is used
> >>      to decode the output and process newlines.
> >>
> >>
> >>>>> subprocess.getstatusoutput(["echo", "hey"])
> >> (0, '')
> >>
> >>>> subprocess.getstatusoutput("echo hey")
> >> (0, 'hey')
> >
> > Indeed, I am so used to subprocess.check_output() and
> > subprocess.Popen(), that can both take arguments as a list, that I
> > expected it to be the same with subprocess.getstatusoutput(), but it
> > is not correct. Sorry for the confusion, and thank you for fixing it!
> >
> > Anyway, using getstatusoutput() by concatenating a path to a command
> > line makes get_xml_file() broken when operating on paths with spaces,
> > as the paths are not quoted nor escaped before they are concatenated.
> > In my humble opinion, I would prefer if the code was written in a more
> > "defensive" way. But because nobody seems to have complained about
> > this so far and because Python's standard library does not help much,
> > I accept keeping getstatusoutput() for now.
> >
> >>>>
> >>>>       from subprocess import getstatusoutput
> >>>>       basedir = os.path.dirname(if_file)
> >>>>       filename = os.path.basename(if_file).split(".")[0]
> >>>>       rc, output = getstatusoutput(["python3",
> >>>> "/usr/share/selinux/devel/include/support/segenxml.py", "-w", "-m",
> >>>> os.path.join(basedir, filename)])
> >>>>
> >>>> The code that I suggest is not compatible with Python 2 (which does
> >>>> not support using list of arguments). Therefore, doing so makes
> >>>> sepolicy really Python-3 only. I do not consider this to be an issue,
> >>>> but others may prefer to wait for 3.0 to be released before dropping
> >>>> support for Python 2 completely.
> >>>
> >>> Anyone else have an opinion on whether we should fix this in a
> >>> python2-compatible manner?
> >>
> >> I'd stay with python2 compatible for now.
> >>
> >>> Also, should it be just "python3" or "/usr/bin/python3"?
> >>
> >> It would be great if it could use $(PYTHON) from Makefile.
> >
> > I agree, but this would be quite complex (the implementations of this
> > idea that I imagine would consists in editing the Python source code
> > with "sed" commands when installing the file). But it would
> > nonetheless be nice if
> > "/usr/share/selinux/devel/include/support/segenxml.py" could also be
> > configured in Makefile...
> > Anyway, for "python3 vs. /usr/bin/python3", I would like to stick as
> > closely as possible with the meaning: use "/usr/bin/..." for
> > system-wide programs/files and use "/usr/bin/env" or "python" for
> > programs that can be run in Python's virtual environments. As
> > /usr/share/selinux/devel/include/support/segenxml.py falls into
> > category "system-wide files", my choice would be for /usr/bin/python3.
>
> So, are people ok with merging the patch as posted in order to fix the
> open issue before the next release?

Yes, even though it would be nicer if the parameters were surrounded
by parentheses: rc, output = getstatusoutput("/usr/bin/python3
/usr/share/selinux/devel/include/support/segenxml.py -w -m %s" %
(basedir + filename))

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Nicolas

