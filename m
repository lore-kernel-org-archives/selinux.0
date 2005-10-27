Subject: Re: [ SEMANAGE ] [ SEPOL ] Implement dbase_policydb_list
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43613FB8.2070307@cornell.edu>
References: <43613FB8.2070307@cornell.edu>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 17:36:30 -0400
Message-Id: <1130448990.18805.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-27 at 16:59 -0400, Ivan Gyurdiev wrote:
> This patch implements dbase_policydb_list on top of count/iterate. It 
> also changes the count() specification to unsigned int everywhere...I 
> probably still shouldn't be casting unsigned int to size_t in  list(), 
> but at least it's better than casting signed int (and producing a warning).
> 
> list() tested and should work.

Thanks, merged as of libsepol 1.9.33 and libsemanage 1.3.38.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
