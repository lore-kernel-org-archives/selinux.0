Subject: Re: [ SEMANAGE 2 ] Fix dbase transactions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <435AC7F5.7030602@cornell.edu>
References: <435AC7F5.7030602@cornell.edu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 13:09:02 -0400
Message-Id: <1130173742.17609.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-10-22 at 19:15 -0400, Ivan Gyurdiev wrote:
> This patch fixes transactions (hopefully). After this patch (and the 
> other 7 previously sent), I can successfully modify selinux users, and 
> write the changes to local file, as well as load them in policy (with 
> the if0-ed code)

All 8 patches merged as of libsepol 1.9.26 and libsemanage 1.3.32.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
