Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAACC04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72742081B
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72742081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDPdM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:33:12 -0500
Received: from uhil19pa14.eemsg.mail.mil ([214.24.21.87]:8936 "EHLO
        UHIL19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeLDPdM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 10:33:12 -0500
X-EEMSG-check-008: 4290828|UHIL19PA14_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 15:32:40 +0000
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="21310492"
IronPort-PHdr: =?us-ascii?q?9a23=3AZT6fIx84Ntd9j/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0OIVIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnhlSskTRrx/TBPr36GZjNNXnCn6n7fb?=
 =?us-ascii?q?lj9kFcyRA/zdBC55hMELEOPOrzWlPttNzfFhI5LQO0w+HnCdpn0oMTQniPDb?=
 =?us-ascii?q?GEP6PSq1CI+vgjLPWLZI8QoDz9MeQq5+byjX8lnl8QZa6p3Z4QaHCjGPRpOV?=
 =?us-ascii?q?mWbmT3j9cbD2gFowo+Q/b2iFGYTTFTYHOyVbom5j4nEIKmEZvDRoe1jbOa0i?=
 =?us-ascii?q?e7H4NZZmRbBVCXCnroeYSEVOkIaC2POc9ujCcEWaKmS4872hGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru1MNv6O3XlRAz9Dx1D8KG3m6XSWF7g3kIRzg33K9iu0By1lCD0a?=
 =?us-ascii?q?1gifxCCdNT/+9JUhs9NZPE1+x1Ec3yWgbac9eRUlmmX9GmDSg0TtI2xN8OeV?=
 =?us-ascii?q?hyF8++gRDE2iqgG6UVmKCTBJwo7qLc2GD8J8J8y3bAyakggEAqQshROm28gK?=
 =?us-ascii?q?5w6QzTCpXXk0WWiamqb74Q3C3T+2eZy2qBokVYXBR3UaXfUnAVflHWosjh5k?=
 =?us-ascii?q?PeU7+uDqwqMg9Ayc6EN6tLZcTljUhARPfiP9TeZWyxm3yrCBaWybODcpDqd3?=
 =?us-ascii?q?8e3CrDEkgElR4c/XKcOQg5HCehrHrUDCZyGlL3f0Ps7e5+pWu/Tk81yQGKck?=
 =?us-ascii?q?Jg26O7+h4OmPOTVe0T0awAuCo6tTV0E0iy38jMB9qDuQVhZqNcbs054Ftd0m?=
 =?us-ascii?q?LZrQN9NIS6L69+nl4ebxh3v0T22hVsFIpAlckqrHU3zAt9Mq+YzlxBeC2C3Z?=
 =?us-ascii?q?zqOb3YNHPy/BaxZK7SwF3e18yW+qgX4vQit1rjpB2pFlYl83h/ztZU3WGT5p?=
 =?us-ascii?q?HRDAoSSp/xSFg4+AV6p77Afikx/Z/b1XppMfr8jjiX/tMqAOw+gi2ycs1SPK?=
 =?us-ascii?q?LMQArzEMkdHOC1OuEwllSoKBIZarN87qkxavi6euOG1ajjB+NpmDarnCwT+4?=
 =?us-ascii?q?xm+l6d/Cp7DOjT1tAKxO/OjVjPbCv1kFr06pO/ootDfzxHWzPlkSU=3D?=
X-IPAS-Result: =?us-ascii?q?A2DjAgD4nAZc/wHyM5BjHAEBAQQBAQcEAQGBZYFbKYFoJ?=
 =?us-ascii?q?4N5lHMBAQEBAQEGgQgIJYkfkCQ4AYRAAoNPIjgSAQMBAQEBAQECAWwogjYkA?=
 =?us-ascii?q?YJiAQUjBBE0CgMQCxgCAiYCAlcGDQYCAQGCXj+BdQ2lCnwzhUCEcoELixMXe?=
 =?us-ascii?q?IEHgREnDIJfhDswgxqCVwKJHIIEhBJGN1CPSgmKNocFBhiRJppUIYFVKwgCG?=
 =?us-ascii?q?AghD4MnkHkhAzCBBQEBiCSCPgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2018 15:32:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4FWZVU027013;
        Tue, 4 Dec 2018 10:32:35 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
 <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
 <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
 <CAJfpegujwNpWL5Eujrb+=EQF8OMOkO03yq8ZZSkfhFfwQvhGKQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6feb656e-b1e3-5839-ce5f-669ae5a55b7f@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 10:35:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegujwNpWL5Eujrb+=EQF8OMOkO03yq8ZZSkfhFfwQvhGKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 9:45 AM, Miklos Szeredi wrote:
> On Tue, Dec 4, 2018 at 3:28 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 12/4/18 8:32 AM, Miklos Szeredi wrote:
> 
>>> My proposed sequence would be
>>>
>>> a) check task's creds against overlay inode, fail -> return fail, otherwise:
>>> b) check mounter's creds against lower inode, success -> return
>>> success, otherwise:
>>> c) copy up inode, fail -> return fail, otherwise
>>> d) check mounter's creds against upper inode, return result.
>>>
>>> So, unlike write access to regular files, write access to special
>>> files don't necessarily result in copy-up.
>>>
>>> You say this is an escalation of privilege, but I don't get it how.
>>> As DWalsh points out downthread, if mounter cannot create device
>>> files, then the copy-up will simply fail.  If mounter can create
>>> device files, then this is not an escalation of privilege for the
>>> mounter.
>>
>> Yes, in that case there isn't an escalation of privilege for the mounter
>> (I acknowledged that above).  I'm still not sure copy-up of special
>> files is a good idea though:
>>
>> - In the case of device files, there is the potential for mischief by
>> the client task in misusing the mounter's privileges to gain access to
>> otherwise unusable device node (nodev lower vs upper?),
> 
> The mount flag "nodev" on lower or upper has no effect on the overlay,
> and never had.
> 
>> - In the case of sockets or fifos, what useful result do you get from a
>> copy-up? Accessing the copy isn't going to yield the same result as
>> accessing the original.
> 
> This is a misconception.  Overlayfs is a filesystem (that uses other
> filesystems as backing store), but it's more a filesystem and less a
> vfs hack (and trying to completely get out of the vfs hack business),
> and copy up has no effect on I/O being performed on a socket or FIFO:
> it's the same object before and after the copy up, and it's a
> different object from either the lower or upper nodes.   Same as NFS:
> fifo on server is logically different object than fifo having the same
> name on any number of clients.
> 
>> For executables, this copy-up behavior might trigger a lot of undesired
>> copies of non-executable files from the lower dir into the upper, even
>> if we ultimately end up denying the execute.
> 
> That would only happen if
> 
>    - task is allowed exec on overlay
>    - mounter is denied exec on lower
>    - copy up is allowed
>    - mounter is denied exec on upper
> 
> In fact in the model where upper object inherits context from overlay
> this is pretty much impossible, AFAICT.

I think the above is the situation in Android (mounter is denied exec to 
lower and upper to prevent unauthorized code execution, but is allowed 
to copy-up in order to support writes by the client).  However, since 
they need override_creds=off or similar anyway, I guess it doesn't matter.

Ok, I concede the point.  Not sure what that means though for v4.20.
