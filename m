Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32AqVoJ029094
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 06:52:31 -0400
Received: from web86903.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l32ApveJ018813
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 10:51:57 GMT
Date: Mon, 2 Apr 2007 10:51:41 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: implementation of conditional policies
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <632374.50812.qm@web86903.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Sorry for this inconvenience. Unfortunately, the problem is still not solved. I relabeled the file /etc/medicalpolicy to 

root:object_r:testfile_t and removed it from the home directory of the root.

the configuration of the refpolicy are:

--myapp.fc
/etc/medicalpolicy  -- gen_context(root:object_r:testfile_t)
and
--myapp.te
policy_module(myapp,1.0)
# Private type declarations
require {
        attribute domain;        
}
#type user_home_t;
#type bin_t;
#type myapp_t;
type testfile_t;
files_type(testfile_t);
bool test false;
if (test) {
    allow domain testfile_t:file {read};
    }


As you mentioned, about the use of strict policy and targeted policy, but when i change the option in the /etc/selinuc/config to strict, to see a chance to get effect of it, at the restart, kernel panics and says selinux is in enforcing mode.....kernel panics....

Perhaps the sources of strict policy are not installed?. Or this kind of policy is not enforced, in the targeted mode of operation of SELinux. any Idea?

Thanks,
JG
----- Original Message ----
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Sent: Friday, 30 March, 2007 1:15:49 PM
Subject: Re: implementation of conditional policies


On Thu, 2007-03-29 at 19:09 +0100, JanuGerman wrote:
> Hi Stephen,
> 
> if you can kindly answer my question. I have the book
> SELinux by example, but beside one chapter, there is
> less help available on the conditional policies.
> Although, i unset the boolean variable, but, every
> program in the /bin can access the test file.
> 
> 
> The context assoicated with the file is:
> root:object_r:user_home_t 

...which is naturally going to be accessible by unconfined_t (or by
user_t, if using strict).

> where as context assoicated with the "vi" is:
> system_u:object_r:bin_t
> 
> The policy is as follows: 
> policy_module(myapp,1.0)
> 
> # Private type declarations
> require {
>         attribute domain;
>         
> }
> 
> type testfile_t;
> #type myapp_t;
> #file_type(testfile_t);

You need to declare testfile_t as a files_type() if you are going to set
it on a file.  

> bool test false;
> 
> 
> if (test) {
>     allow domain testfile_t:file {read};

But you said the file was labeled user_home_t, not testfile_t, above,
and regardless, unconfined_t under targeted policy can do everything.

-- 
Stephen Smalley
National Security Agency




	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
