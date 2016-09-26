MIME-Version: 1.0
In-Reply-To: <a353aab5-b4ae-c6e5-82fa-4326f1f841f6@tycho.nsa.gov>
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
 <a353aab5-b4ae-c6e5-82fa-4326f1f841f6@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 26 Sep 2016 12:47:38 -0700
Message-ID: <CAFftDdqZY4Cnbh5+pw9cW185m0mMSRT0bAMxd5GN9r9=APLwNw@mail.gmail.com>
Subject: Re: Android Fork
To: Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 Daniel Cashman <dcashman@android.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 Janis Danisevskis <jdanis@google.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 26, 2016 at 12:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/26/2016 01:33 PM, william.c.roberts@intel.com wrote:
>> Below, are the last two majore patches to close the Android fork.
>>
>> Patch "libselinux: add ifdef'ing for ANDROID and BUILD_HOST" I
>> combined into 1 patch since some ANDROID and BUILD_HOST defines
>> are on the same line, I can split it appart if its really needed.
>>
>> Note, that you need the Android make recipe for some of these
>> configurations to work as Android doesn't use all the src files.
>>
>> The Build files are left out, for now, so AOSP can pull from
>> upstream without it breaking the AOSP build.
>>
>> Once merged AOSP can take the build files, once they drop
>> external/libselinux, and then the last patch u[stream will
>> be the enabling patch with the build files.
>
> I was wondering whether the build files belong in upstream.
> I know we have them for libsepol and checkpolicy currently, but
> essentially they are just always out of date, any changes will be fed
> through Android first anyway, and they aren't getting any testing or
> updates from upstream.  Might be simpler to just keep those in Android
> and drop the ones we already have from upstream.

+ AOSP folks.

I've been pondering the same thing, so I am glad one of us started this
discussion. Based on what your stating, I think it makes sense to kill
the Android.mk and Android.bp files upstream, but ill let the AOSP
folks chime in as well.

I think it also makes sense to add ANDROID_HOST=y option for the build
so we can at least test the Android host recipe within the upstream Makefiles,
thoughts?

<snip>
