Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7KL32fG025258
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 17:03:02 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7KL31Sr024748
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 21:03:01 GMT
Received: from mail.atsec.com (localhost [127.0.0.1])
	by mail.atsec.com (Postfix) with ESMTP id BF0AE7209ED
	for <selinux@tycho.nsa.gov>; Mon, 20 Aug 2007 23:03:00 +0200 (CEST)
Date: Mon, 20 Aug 2007 16:02:56 -0500
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, joe@nall.com
Subject: Re: MLS directory write constraints
Message-ID: <20070820210256.GB23508@w-m-p.com>
References: <1187613297.27524.10.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1187613297.27524.10.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 20, 2007 at 08:34:57AM -0400, Christopher J. PeBenito wrote:
> But since creating or deleting a file in a directory requires write and
> add_name or remove_name, respectively, you still must have equality in
> level to create a file in /var/run.  Because of this, I believe there
> potentially are superfluous write downs for daemons that don't run in
> system low.  I think the constraints should be changed to this:

Here's a link to a previous discussion on this list about the
directory constraints:

  http://www.nsa.gov/selinux/list-archive/0612/18627.cfm

(Subject "[PATCH RFC 0/2] stricter MLS policy constraints", Dec 12 2006)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
