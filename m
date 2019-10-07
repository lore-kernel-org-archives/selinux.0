Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DFAC47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F912084D
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 13:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eHjGojRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfJGNXX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:23:23 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:62825 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfJGNXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 09:23:23 -0400
X-EEMSG-check-017: 32886504|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="32886504"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Oct 2019 13:23:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570454602; x=1601990602;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4TcV5bbjyBh+Qmq8NR5uPCcg8I0cNfZgcaz1Fu2loa4=;
  b=eHjGojRv+KU3RN4MEYqJwzz1x++pKRH+TUs8Plg5Jd4cKXoJsy6uUeao
   90dvzwnpCwvS8D1SoZnPVmxKIc146bPfgvIpSPm9g1AZmF8X+alUT7pxT
   SvjgbN18fwZq9k6Et0SW2Q5dwfB2gNuFmXEyjbhuMSEb8gimqjZcmXkvZ
   B+DrMPj6FHnzbW6yyd/fQq94MROCdsYcAM6Q2bGdCfp4V9CXfVPgslZ2m
   jcdrDJA25/darEpZmGYVISq3oY1kh4yfYxYfAzO0J2VDaq7VVoJ4zBX3a
   xay9c1UDR1v6ssR11N08T67URffcYmNh6WyHdT3sYjF3CsaJvmZGH/BM6
   g==;
X-IronPort-AV: E=Sophos;i="5.67,268,1566864000"; 
   d="scan'208";a="33824312"
IronPort-PHdr: =?us-ascii?q?9a23=3AxxtTCxbFKcxrpngRNqI7U23/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy+bR7h7PlgxGXEQZ/co6odzbaP6Oa9BidcvN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twXcu8sZjYZtKqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IQoRa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4sTWFvvSY10LwGuZ?=
 =?us-ascii?q?ijcScUzpQn2R/fa+aAc4iO5xLsSuCRIStjhH5/Yr2/nA6+8Uehyu3gVsm0zU?=
 =?us-ascii?q?1FojBZndnLs3ABzwTT68ibSvt9+Ueh3yyD1wfJ6uFLJ00/iKnVK4Y5z7ItmZ?=
 =?us-ascii?q?cevl7PEy/rlEnskqObeVso9vK15+nhf77ovIWTN5VuhQH7Kqkun8u/DvkmPQ?=
 =?us-ascii?q?UWRGib/Pi81KXk/U3kXLVGlv02nbfdsJDdPckburS2AxVU0oY+8BazFSum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHgJTyO17SOvz4CPa/g1C0nDdqwfDJIKHhD43QInXMn7rtZ7?=
 =?us-ascii?q?Zw51NGxAYtwt1T+YhYBqwZLPL2QEDxtdjYDhEjMwyzxubqEM592Z4FWW+UHq?=
 =?us-ascii?q?+YML/dsV+P5u41JemMf5UatCzyK/gi+f7ilWU5lkMFfam1wZsXb2i1HvJnI0?=
 =?us-ascii?q?qFZnrshs0OEXwQsgo/S+zqj0aCUSVIana3UK896Ss3CIW8DYfMXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLEkiMEXPyeIWZR/cMcjmdLdV6nzweS7euVo8h2guytAPg17VnKe?=
 =?us-ascii?q?/U8DUCtZ3/zNh1+/HTlRYq+DxvEcud12CNT2dpnmIHXDI2wq9/rlJnyluZ0q?=
 =?us-ascii?q?h3neZYFdpN6PNNSAs6MoTcz+MpQ+z1DyTAddCNQU3uY9KhGip5GtQwyNgKal?=
 =?us-ascii?q?07GtKllQvr2na6RbgPmOrPTKQ57riU+3HsO9x3wn3GnP05i1A7XtFFPEW8i6?=
 =?us-ascii?q?J//hSVDInMxRa3jaGvIJ8A0TbN+WHL9m+HuEVVQUYkSqnedWwObUvR69Li7w?=
 =?us-ascii?q?XNSKH4WudvCRdI1cPXcvgCUdbul1gTAa65adk=3D?=
X-IPAS-Result: =?us-ascii?q?A2B+AADfOJtd/wHyM5BmHAEBAQQBAQwEAQGBVAYBAQsBg?=
 =?us-ascii?q?XMqbVMyKoQjjzMGgTaJd48zFIFnCQEBAQEBAQEBASsJAQIBAYN7RQKCWyM1C?=
 =?us-ascii?q?A4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJoAQUjFUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/AYF2FA+uA4EyhExBQIMygUiBDCgBjA0YeIEHgTiBbX4+gmECAYEpH?=
 =?us-ascii?q?4MlglgEliOXGYIsgjCEWYUXiHIGG4MslhOOLIghkwwBN4FYKwgCGAghDzuCb?=
 =?us-ascii?q?AlHEBSFQoUUUYUKJQMwAYEFAQGOEIJUAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Oct 2019 13:23:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x97DNJh4010745;
        Mon, 7 Oct 2019 09:23:20 -0400
Subject: Re: [PATCH] python/sepolicy: call segenxml.py with python3
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190926125218.22958-1-sds@tycho.nsa.gov>
 <CAJfZ7=ntt2dH6PN3tMQMdw99x4dpU3eRoAd62W4Fqgkvt5Lb5g@mail.gmail.com>
 <e96c532b-f469-fd52-ce6d-3e71dc9e145a@tycho.nsa.gov>
 <pjd4l0thhnr.fsf@redhat.com>
 <CAJfZ7=n09Qz9OxSURCAqdHbMif9qEeRmVq9yk77upDTaDN0M4Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8c34a153-c8b4-8b5d-9d49-a82791a59fc6@tycho.nsa.gov>
Date:   Mon, 7 Oct 2019 09:23:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=n09Qz9OxSURCAqdHbMif9qEeRmVq9yk77upDTaDN0M4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 3:36 PM, Nicolas Iooss wrote:
> On Mon, Sep 30, 2019 at 6:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>
>>> On 9/26/19 5:58 PM, Nicolas Iooss wrote:
>>>> On Thu, Sep 26, 2019 at 2:52 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>
>>>>> Fixes: https://github.com/SELinuxProject/selinux/issues/61
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> ---
>>>>>    python/sepolicy/sepolicy/interface.py | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
>>>>> index 583091ae18aa..b1b39a492d73 100644
>>>>> --- a/python/sepolicy/sepolicy/interface.py
>>>>> +++ b/python/sepolicy/sepolicy/interface.py
>>>>> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>>>>>            from subprocess import getstatusoutput
>>>>>        basedir = os.path.dirname(if_file) + "/"
>>>>>        filename = os.path.basename(if_file).split(".")[0]
>>>>> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>>>>> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
>>>>>        if rc != 0:
>>>>>            sys.stderr.write("\n Could not proceed selected interface file.\n")
>>>>>            sys.stderr.write("\n%s" % output)
>>>>
>>>> Considering that Python's "command" module was removed in Python 3
>>>> (according to https://docs.python.org/2/library/commands.html), and
>>>> that Python 3's subprocess.getstatusoutput() supports using a list of
>>>> arguments instead of a string, it seems better to change this code to
>>>> something like:
>>
>> I think this is not correct:
>>
>>      Execute the string 'cmd' in a shell with 'check_output' and
>>      return a 2-tuple (status, output). The locale encoding is used
>>      to decode the output and process newlines.
>>
>>
>>>>> subprocess.getstatusoutput(["echo", "hey"])
>> (0, '')
>>
>>>> subprocess.getstatusoutput("echo hey")
>> (0, 'hey')
> 
> Indeed, I am so used to subprocess.check_output() and
> subprocess.Popen(), that can both take arguments as a list, that I
> expected it to be the same with subprocess.getstatusoutput(), but it
> is not correct. Sorry for the confusion, and thank you for fixing it!
> 
> Anyway, using getstatusoutput() by concatenating a path to a command
> line makes get_xml_file() broken when operating on paths with spaces,
> as the paths are not quoted nor escaped before they are concatenated.
> In my humble opinion, I would prefer if the code was written in a more
> "defensive" way. But because nobody seems to have complained about
> this so far and because Python's standard library does not help much,
> I accept keeping getstatusoutput() for now.
> 
>>>>
>>>>       from subprocess import getstatusoutput
>>>>       basedir = os.path.dirname(if_file)
>>>>       filename = os.path.basename(if_file).split(".")[0]
>>>>       rc, output = getstatusoutput(["python3",
>>>> "/usr/share/selinux/devel/include/support/segenxml.py", "-w", "-m",
>>>> os.path.join(basedir, filename)])
>>>>
>>>> The code that I suggest is not compatible with Python 2 (which does
>>>> not support using list of arguments). Therefore, doing so makes
>>>> sepolicy really Python-3 only. I do not consider this to be an issue,
>>>> but others may prefer to wait for 3.0 to be released before dropping
>>>> support for Python 2 completely.
>>>
>>> Anyone else have an opinion on whether we should fix this in a
>>> python2-compatible manner?
>>
>> I'd stay with python2 compatible for now.
>>
>>> Also, should it be just "python3" or "/usr/bin/python3"?
>>
>> It would be great if it could use $(PYTHON) from Makefile.
> 
> I agree, but this would be quite complex (the implementations of this
> idea that I imagine would consists in editing the Python source code
> with "sed" commands when installing the file). But it would
> nonetheless be nice if
> "/usr/share/selinux/devel/include/support/segenxml.py" could also be
> configured in Makefile...
> Anyway, for "python3 vs. /usr/bin/python3", I would like to stick as
> closely as possible with the meaning: use "/usr/bin/..." for
> system-wide programs/files and use "/usr/bin/env" or "python" for
> programs that can be run in Python's virtual environments. As
> /usr/share/selinux/devel/include/support/segenxml.py falls into
> category "system-wide files", my choice would be for /usr/bin/python3.

So, are people ok with merging the patch as posted in order to fix the 
open issue before the next release?

