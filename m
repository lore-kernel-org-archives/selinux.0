Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k034GgXf014102
	for <selinux@tycho.nsa.gov>; Mon, 2 Jan 2006 23:16:42 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k034Fgqa019246
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 04:15:42 GMT
Message-ID: <43B9FAAD.10809@redhat.com>
Date: Mon, 02 Jan 2006 23:16:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: libsetrans and libselinux
References: <200601031411.13500.russell@coker.com.au>
In-Reply-To: <200601031411.13500.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> Does it make sense to have two separate libraries for these functions?
>
> It seems that they are both maintained by much the same group of people, will 
> in many cases need updating at the same time, and will mostly be linked to by 
> all the same programs, very few programs need libselinux but not libsetrans 
> and that number is constantly decreasing and it's impossible to use 
> libsetrans without using libselinux.
>
> If we have a single library then there are some small optimisations that will 
> occur, reducing load time and reducing the resident set size by a couple of 
> pages.
>
>   
The reason they are separate is so that you could build a replacement 
for libsetrans and use it with libselinux.  The idea was someone
might use the Mitre tranaslation library in place of libsetrans.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
