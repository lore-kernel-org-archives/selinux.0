Subject: Re: [RFC][PATCH] libselinux: refactored SWIG bindings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Athey <jathey@tresys.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Ted X Toth <txtoth@gmail.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1181744873.18728.10.camel@exodus.columbia.tresys.com>
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 07:40:54 -0400
Message-Id: <1182253254.15064.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 10:27 -0400, James Athey wrote:
> I've attached refactored SWIG bindings for libselinux.  As
> requested, I've moved the Python specific wrappers into their own file.
> Here are some of the highlights:
> 
> * Should leak a lot less memory, because the wrapper handles memory
> management for lists and strings automatically
> * security_get_boolean_names is now usable
> * Instead of whitelisting functions to be wrapped, it blacklists
> functions that should not be wrapped
> 
> It's still not an ideal wrapper, partly because many functions still
> return two values - a return code, and the actual returned data.  In
> every language except C, the desired semantics would be just returning
> the data and throwing an exception if the return code != 0.  I didn't
> add this feature because it would definitely break existing code.

Ted reports that this patch solves his problems with the libselinux
python bindings.  However, I noticed that it breaks
system-config-selinux due to excluding selinux_raw_to_trans_context and
friends.  Dan, can you check over the patch and see if there are any
other omissions from these python bindings that you need?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
