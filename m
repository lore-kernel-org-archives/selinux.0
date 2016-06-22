Subject: Re: sandbox - trying to use it / some bugs
To: linseonn.20.mddlr@spamgourmet.com, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>, Petr Lautrbach <plautrba@redhat.com>,
 Miroslav Grepl <mgrepl@redhat.com>
References: <CAADqsPgoRt8We_qNd26PO5QjjKsnfeXHfZ=BnYKZm7oD=E713A@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <08125768-b9fe-a7b7-37ff-96987b1d3808@tycho.nsa.gov>
Date: Wed, 22 Jun 2016 14:40:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAADqsPgoRt8We_qNd26PO5QjjKsnfeXHfZ=BnYKZm7oD=E713A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/17/2016 04:54 PM, linseonn.20.mddlr@spamgourmet.com wrote:
> There is a tool - sandbox - in policycoreutils.   I wanted to use it
> to provide a way to more safely possibly hostile files sent from
> semi-"trusted" people.  E.g.
> 
>    sandbox -X -i ~/myfile1.doc libreoffice  ~/myfile1.doc
> 
> Doing this I came across a couple of problems and would like some
> advice / help with fixes
> 
> The first thing is that, for files that are in the user's home
> directory and have normal user contexts (e.g. on default Fedora 23
> install unconfined_u:object_r:user_home_t) the program in the sandbox
> simply fails to access the file.
> 
>   Full bug report:
> 
>    https://github.com/SELinuxProject/selinux/issues/16
> probably also
>    https://bugzilla.redhat.com//show_bug.cgi?id=1317046
> 
> 
> As I started debugging,  the second thing is that it appears that the
> intention of the different sandbox types doesn't match the
> documentation which is confusing.
> 
>   https://github.com/SELinuxProject/selinux/issues/17
> 
> so I propose a patch for it
> 
>    https://github.com/SELinuxProject/selinux/pull/18
> 
> 
> Please can someone look at these and comment back.
> 
>  - Is the doc fix correct? if so, could someone please accept it
>  - is the correct thing for sandbox to do to change the context as it
> copies files into the sandbox?
>  - is there some more reliable / better already existing alternative to sandbox?
> 
> Thanks in advance for any help anyone can give

Thanks for the doc fix.

At the moment, sandbox -X seems to be broken for me for other reasons
(fails on importing gtk due to python3 changes) in both F23 and rawhide
(probably F24 too).

The files passed to -i should be copied into the temporary sandbox
directory and inherit its context, not be labeled with the context of
the original file.  Oddly, I see different behaviors here for F23 vs
rawhide when using e.g. sandbox -M -i /path/to/file /bin/bash and then
ls -Z /path/to/file.
