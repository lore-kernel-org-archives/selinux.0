Message-ID: <424C1562.5060108@trustedcs.com>
Date: Thu, 31 Mar 2005 09:21:06 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>, Steve G <linux_4ever@yahoo.com>,
   selinux@tycho.nsa.gov
Subject: Re: Getting the real task name in avc messages
References: <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>	 <424B27BA.8060706@trustedcs.com> <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2005-03-30 at 16:27 -0600, Darrel Goeddel wrote:
>>You could also just do:
>>
>>	task_lock(current);
>>	audit_log_format(ab, " comm=%s", current->comm);
>>	task_unlock(current);
>>
>>This avoids an unnecessary copy since we have no use the data after the
>>audit_log_format call.
> 
> 
> Is this locking truly necessary when accessing current->comm (as opposed
> to accessing the comm of another task)?  Can it be set by any other
> task?  We don't presently hold the lock when accessing it in avc_audit.
> 
> 

I didn't not think so, but I wasn't 100% sure.  I only did a quick glance before 
and thought it best to be safe.  Upon further investigation, it sure looks to be 
fine without holding the task lock.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
