Message-ID: <441EC183.6000404@redhat.com>
Date: Mon, 20 Mar 2006 09:51:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Valdis.Kletnieks@vt.edu, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Changes to policycoreutils.
References: <441B2C7B.7050307@redhat.com>	 <200603180532.k2I5Wuhe004158@turing-police.cc.vt.edu>	 <441C3B52.7060702@redhat.com> <1142862355.16487.7.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142862355.16487.7.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2006-03-18 at 11:54 -0500, Daniel J Walsh wrote:
>   
>> The answer is that is, if the file is created by a confined domain it 
>> will be instantly.  SELinux
>> aware application also create it instantly.  This is more for the non 
>> SELinux aware applicaitons. 
>> So the example of the user creating the public_html directory. 
>>
>> It happens very fast, as a matter of fact you can try this command to see it
>>
>> rmdir public_html; mkdir public_html; ls -ldZ public_html
>> drwxrwxr-x  dwalsh   dwalsh   user_u:object_r:httpd_sys_content_t 
>> public_html
>>
>> This should not be considered a failsafe security measure, but more of a 
>> usability issue.
>> If you have an file that is of critical secuirty you might not want to 
>> use this tool on it.
>>     
>
> It shouldn't be applied to any directory writable by an untrusted entity
> (e.g. ~/public_html) unless you are taking some kind of safeguards to
> prevent it from being used as a way to relabel files outside the user's
> control via links.
>
>   
Not sure what you mean.  It is taking into account the users homedir.  
And the file.  If public_html was not a directory it would be labeled 
user_home_t.  I don't know how someone could cause the relabel to be a 
problem.   I guess if the administrator was to start to add files in 
/tmp or ~/subdir/subdir/SecretFile.  This could be a problem. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
