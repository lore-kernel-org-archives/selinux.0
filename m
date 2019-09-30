Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CAC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA492075D
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 16:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfI3Q3P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfI3Q3P (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 30 Sep 2019 12:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCE4D3001A6C;
        Mon, 30 Sep 2019 16:29:14 +0000 (UTC)
Received: from localhost (ovpn-204-128.brq.redhat.com [10.40.204.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3134319C58;
        Mon, 30 Sep 2019 16:29:14 +0000 (UTC)
References: <20190926125218.22958-1-sds@tycho.nsa.gov> <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com> <e96c532b-f469-fd52-ce6d-3e71dc9e145a@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] python/sepolicy: call segenxml.py with python3
In-reply-to: <e96c532b-f469-fd52-ce6d-3e71dc9e145a@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 18:29:12 +0200
Message-ID: <pjd4l0thhnr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 30 Sep 2019 16:29:14 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 9/26/19 5:58 PM, Nicolas Iooss wrote:
>> On Thu, Sep 26, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> Fixes: https://github.com/SELinuxProject/selinux/issues/61
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>   python/sepolicy/sepolicy/interface.py | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
>>> index 583091ae18aa..b1b39a492d73 100644
>>> --- a/python/sepolicy/sepolicy/interface.py
>>> +++ b/python/sepolicy/sepolicy/interface.py
>>> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>>>           from subprocess import getstatusoutput
>>>       basedir = os.path.dirname(if_file) + "/"
>>>       filename = os.path.basename(if_file).split(".")[0]
>>> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>>> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>>>       if rc != 0:
>>>           sys.stderr.write("\n Could not proceed selected interface file.\n")
>>>           sys.stderr.write("\n%s" % output)
>>
>> Considering that Python's "command" module was removed in Python 3
>> (according to https://docs.python.org/2/library/commands.html), and
>> that Python 3's subprocess.getstatusoutput() supports using a list of
>> arguments instead of a string, it seems better to change this code to
>> something like:

I think this is not correct:

    Execute the string 'cmd' in a shell with 'check_output' and
    return a 2-tuple (status, output). The locale encoding is used
    to decode the output and process newlines.


>>> subprocess.getstatusoutput(["echo", "hey"])
(0, '')

>> subprocess.getstatusoutput("echo hey")
(0, 'hey')


>>
>>      from subprocess import getstatusoutput
>>      basedir = os.path.dirname(if_file)
>>      filename = os.path.basename(if_file).split(".")[0]
>>      rc, output = getstatusoutput(["python3",
>> "/usr/share/selinux/devel/include/support/segenxml.py", "-w", "-m",
>> os.path.join(basedir, filename)])
>>
>> The code that I suggest is not compatible with Python 2 (which does
>> not support using list of arguments). Therefore, doing so makes
>> sepolicy really Python-3 only. I do not consider this to be an issue,
>> but others may prefer to wait for 3.0 to be released before dropping
>> support for Python 2 completely.
>
> Anyone else have an opinion on whether we should fix this in a
> python2-compatible manner?

I'd stay with python2 compatible for now.

> Also, should it be just "python3" or "/usr/bin/python3"?

It would be great if it could use $(PYTHON) from Makefile.


>>
>> By the way, the current code is quite misleading because ("%s" % a +
>> b) is interpreted as (("%s" % a) + b), not ("%s" % (a + b)).
>> Thankfully the "%s" is at the end of the format string, but if you
>> want to keep Python 2 compatibility, I suggest adding parentheses
>> somewhere.


-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments
