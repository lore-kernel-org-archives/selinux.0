Subject: Re: [PATCH] libselinux lazy init
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1174317406.22565.112.camel@moss-spartans.epoch.ncsc.mil>
References: <183389.69237.qm@web51509.mail.re2.yahoo.com>
	 <1174317406.22565.112.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 13:13:17 -0400
Message-Id: <1174324397.22565.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-19 at 11:16 -0400, Stephen Smalley wrote:
> On Sun, 2007-03-18 at 06:28 -0700, Steve G wrote:
> > Hi,
> > 
> > Attached is the re-worked (and tested) patch that changes libselinux's startup
> > behavior of reading /etc/selinux/config to be on-demand. This improves
> > performance measurably for small programs that do not need to know the details of
> > policy. (Examples are cp, ls, id, install, ...) Please apply.
> > 
> > Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>
> 
> Did you test the impact on a multi-threaded user of libselinux, like
> dbusd?

Also, can you comment on why you chose not to pursue Ulrich's suggested
approach?  Just lack of time or was there a technical reason?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
