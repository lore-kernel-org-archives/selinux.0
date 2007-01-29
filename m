Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TEhZXB012440
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 09:43:35 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TEibfV019462
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:44:37 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1802454wxc
        for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 06:44:37 -0800 (PST)
Message-ID: <45BE0843.2040204@kaigai.gr.jp>
Date: Mon, 29 Jan 2007 23:44:19 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: russell@coker.com.au
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, busybox@busybox.net,
        selinux@tycho.nsa.gov, rob@landley.net, dwalsh@redhat.com,
        busybox@kaigai.gr.jp, vda.linux@googlemail.com
Subject: Re: [PATCH 5/8] busybox -- libselinux utilities applets
References: <45B8C039.10907@kaigai.gr.jp> <45B8C25C.6090705@kaigai.gr.jp> <1169842227.25290.8.camel@sgc.columbia.tresys.com> <200701292328.37290.russell@coker.com.au>
In-Reply-To: <200701292328.37290.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Thanks for your comments.

Russell Coker wrote:
> On Saturday 27 January 2007 07:10, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
>> On Thu, 2007-01-25 at 23:44 +0900, KaiGai Kohei wrote:
>>> [5/8] busybox-libselinux-05-avcstat.patch
>>>   avcstat reports SELinux AVC(Access Vector Cache) statistics.
>>>   AVC is a in-kernel data structure to accelerate SELinux's
>>>   decision making.
>> Are you sure this should be added?  It doesn't seem like it would be
>> used much.  I don't think most people are even aware that you can get
>> stats on the AVC, much less know what to do with them.
> 
> I agree.  avcstat is used only rarely and only in development.  I don't think 
> that it's something we need in production on an iPaQ, for system recovery, or 
> in an initramfs - therefore I think it's something that isn't needed in 
> busybox.
> 
> As for togglesebool, should such a thing even exist?  Before we had setenforce 
> we had avc_toggle which was very similar to togglesebool - and it was 
> generally regarded that avc_toggle should not exist.

Our primary motivation is that porting some of significant SELinux utilities
without any unexpected incompatibility.
Therefore, the serious of patches implements all of liblisenux utilities.

But your opinions are persuasive, I can agree to suspend the patches of
avcstat and togglesebool.

Denis, I would like to suspend the 5th and 6th patches by above reason.

> Good work on the busybox development KaiGai, it's something that needed to be 
> done for a while.  But I think you were a little over-enthusiastic in regard 
> to those two commands.

The list of our works (which include unsubmitted ones) are here:
   http://code.google.com/p/sebusybox/

We want any comments about its necessity and so on.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
