Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2BHgDhv018113
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 12:42:13 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2BHfpnE000552
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 17:41:52 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2BHgBJd029449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 12:42:11 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2BHgA2h025181
	for <selinux@tycho.nsa.gov>; Thu, 11 Mar 2010 12:42:10 -0500
Message-ID: <4B992B72.7070907@redhat.com>
Date: Thu, 11 Mar 2010 12:42:10 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: how to cope with file renames?
References: <20100311081913.GC24034@myhost.felk.cvut.cz> <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil> <20100311170014.GE24034@myhost.felk.cvut.cz>
In-Reply-To: <20100311170014.GE24034@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/11/2010 12:00 PM, Michal Svoboda wrote:
> Stephen Smalley wrote:
>    
>> http://pecl.php.net/package/selinux
>>      
> Thanks!
>
>    
>>> In short, I was wondering if there was a way for a rename()d file to be
>>> subjected to a type transition as if a new file was created? (I tried a
>>> type_trans rule but to no avail.) Or any other way to deal with renaming
>>> files between variously contexted dirs?
>>>        
>> No.  The best way of course is to create the file with the right
>> security context in the first place, whether explicitly or by uploading
>> it to the same parent directory as the final destination.
>>      
> That's what I do right now. I can do that because there's only one
> context. But in a web service your script isn't invoked until the file
> is already uploaded. So you can't pre-set the correct context and/or
> destination if you have two or more possibilities.
>
>    
>> Alternatively the php scriptlet can use the selinux bindings to
>> manipulate the context, or you can configure restorecond(8) to watch
>> for the destination file and reset its security context as needed.
>>      
> Does restorecond handle recursive directory restoring yet? (Last time I
> tried it worked only on single files.)
>
> But yes, in principle a cron job with 'restorecon -R' is a way too. But
> all those solutions are 'dirty', because they need you to make an extra
> effort. There's already a huge infrastructure with type inheritance and
> transitions, as to make the labeling independent of the application; but
> the rename operation just spoils that and forces you back to square one,
> to explicitly care about your files' contexts. Is there a fundamental
> reason why this is so (and can't be changed)?
>
>
> Michal Svoboda
>    
restorecond can handle * But not recursive.

You can watch ~/* for all entries in the homedir.  It would not be hard 
to add a watch an entire tree.

Just need to walk the tree adding watches for ever directory and any 
time a a new directory shows up you would add it to the watch list.  I 
am not sure how much inotify can handle.  We might get in trouble with 
the amount of resoures used.

~/...

Could watch millions of directories.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
