Subject: Re: libselinux: Provide new labeling backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rpcraig <rpcraig@tycho.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4F7F4FD5.30108@tycho.ncsc.mil>
References: <4F7F4FD5.30108@tycho.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Apr 2012 13:01:08 -0400
Message-ID: <1333990868.8497.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-04-06 at 16:19 -0400, rpcraig wrote:
> I have attached a patch which provides a new labeling backend
> directed at the Android property service keys.

Reviewed-by:  Stephen Smalley <sds@tycho.nsa.gov>

Eric, you may want to run scripts/Lindent on
src/label_android_property.c afterward to fix up some whitespace issues.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
