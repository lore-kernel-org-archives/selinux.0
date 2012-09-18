Message-ID: <1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: seandroid 4.1.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 18 Sep 2012 13:13:44 -0400
In-Reply-To: <CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
References: 
	<CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-09-18 at 12:28 +0200, Alexandra Test wrote:
> Hi all,
> I update the release of Seandroid on Samsung Galaxy Nexus.
> Unfortunately the camera and the wifi seem to not be working.
> 
> 
> Anyone has the same problem? 

I have wifi working.  The camera proprietary binary isn't available for
AOSP.  You downloaded the jro03h files, expanded them, ran the extract
scripts, did a make clobber, and then rebuilt?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
